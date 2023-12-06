//
//  CryptoList1.swift
//  CryptoVote
//
//  Created by Sharapov on 11/8/23.
//  Copyright © 2023 Muzaffar Sharapov. All rights reserved.
//
//Description: The CryptoList.swift file is part of the CryptoVote iOS application and focuses on displaying cryptocurrency information. The CryptoList class, inheriting from UITableViewController and conforming to UISearchBarDelegate, manages a table view to present cryptocurrency data. Its main functionalities include downloading JSON data from an API, parsing this data into structured models (cryptoCoinCapJson and cryptoCoinCapJsonPeriod), and dynamically displaying it in the table view. The class also integrates a search bar for filtering cryptocurrencies based on user input, enhancing interactivity. It handles user interface considerations like dark mode compatibility and customizes the appearance of the navigation and search bars. Additional methods like handleRefresh are implemented for updating the table view data, ensuring the information remains current. The class thus serves as a key component in the CryptoVote app, offering a detailed and searchable interface for cryptocurrency statistics.

import UIKit



private let reuseIdentifer = "CryptoListCell"

class CryptoList: UITableViewController, UISearchBarDelegate  {
    
    
    

    var searchBar = UISearchBar()
    var inSearchMode = false
    var currentKey: String?

    var cryptStat: cryptoCoinCapJson?
    var crypto: [cryptoCoinCapJsonPeriod]?
    var cryptos = [cryptoCoinCapJson]()

    var arraySymbol = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

               
         
        
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.tableView.separatorStyle = .none

        
        view.backgroundColor = .white
        if #available(iOS 13.0, *) {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .clear
            view.backgroundColor = UIColor(named: "backgroundColor")
            tableView.backgroundColor = UIColor(named: "backgroundColor")
        } else {
            view.backgroundColor = .clear
            view.backgroundColor = UIColor(named: "backgroundColor")
        }
        } else {
            print("nochange")
        }
            
            
            


        
        
        
        downloadJSON {
            self.tableView.reloadData()
            }

        self.refreshControl = UIRefreshControl()
        
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.tableView?.refreshControl = refreshControl
        
        self.tableView!.register(CryptoListCell.self, forCellReuseIdentifier: reuseIdentifer)
        
        searchBars()
     
        

    }
    
    

    
    
    @objc func handleRefresh() {
        cryptos.removeAll(keepingCapacity: false)
        self.currentKey = nil
        self.downloadJSON {
            self.tableView.reloadData()
        }
        self.refreshControl?.endRefreshing()
        do {
            
            self.tableView?.reloadData()
            
            
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true


    }


    
    
    
    func searchBars()
    {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        

       
        searchBar.placeholder = "Search"
                searchBar.sizeToFit()
        
                searchBar.delegate = self
                navigationItem.titleView = searchBar
                searchBar.barTintColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        searchBar.tintColor = UIColor(named: "colorLetter")
        searchBar.backgroundColor = UIColor(named: "backgroundColor")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" || searchText.isEmpty {
            inSearchMode = false
            downloadJSON(completed: {
                _ = ((String,String) -> ()).self
                self.tableView.reloadData()

                
            })
        }
        else{
            if searchBar.selectedScopeButtonIndex == 0 {
                cryptStat!.data = cryptStat!.data.filter({ (name) -> Bool in
                    let name = name
                    
                    return (name.symbol?.lowercased().contains(searchText.lowercased()) ?? false)
                    
                })
            }
        }
        self.tableView.reloadData()
    }
    
    
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
            searchBar.showsCancelButton = false
            searchBar.text = nil
          //  searchBar.placeholder = "Search"
            
            
            
            inSearchMode = false
    
        //    collectionViewLayout = true
            tableView.isHidden = false
    
        //    collectionView.separatorColor = .clear
            tableView.reloadData()
        }
    
    

    
    
    @objc func cancelNumberPad() {
        searchBar.endEditing(true)
        //    searchBar.showsCancelButton = false
        searchBar.text = nil
        //    inSearchMode = false
        
        //    collectionViewLayout = true
        tableView.isHidden = false
        
        //    collectionView.separatorColor = .clear
        tableView.reloadData()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
    }
    
    @objc func dismissKeyboard() {

        searchBar.endEditing(true)
    //    searchBar.showsCancelButton = false
        searchBar.text = nil
    //    inSearchMode = false

        //    collectionViewLayout = true
        tableView.isHidden = false

        //    collectionView.separatorColor = .clear
        tableView.reloadData()




    }
    
    

    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cryptStat?.data.count ?? 0
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! CryptoListCell

        

        
         cell.crypto = cryptStat?.data[indexPath.row]
        
        
        return cell
    
    }
    
    
    
    
    

    
    
    
    func downloadJSON(completed: @escaping () -> ()) {
        
        let url = URL(string: "https://api.coincap.io/v2/assets")
        //     let url = URL(string: "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&limit=100")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
        
            guard let data = data else {return}
            
            if error == nil {
                do {
                    
                    let cryptos = try JSONDecoder().decode(cryptoCoinCapJson.self, from: data)
                    
                    
                    DispatchQueue.main.async {
                        
                        
                        self.cryptStat = cryptos
                        
                        
                        
                        
                        completed()
                        self.tableView.reloadData()
                        
                    }
                }catch {
                    print("JSON Error", error.localizedDescription)
                }
            }
            }.resume()
    }
    
}


struct cryptoCoinCapJson: Decodable {
    
    var data: [cryptoCoinCapJsonPeriod]
    
}


struct cryptoCoinCapJsonPeriod: Decodable {
    
    let id: String?
    let priceUsd: String?
    let symbol: String?
    let marketCapUsd: String?
    let supply: String?
    let maxSupply: String?
    let volumeUsd24Hr: String?
    let changePercent24Hr: String?
    init(id: String, priceUsd: String, symbol: String, marketCapUsd: String, supply: String, maxSupply: String, volumeUsd24Hr: String, changePercent24Hr: String){
        
        self.id = id
        self.priceUsd = priceUsd
        self.symbol = symbol
        self.marketCapUsd = marketCapUsd
        self.supply = supply
        self.maxSupply = maxSupply
        self.volumeUsd24Hr = volumeUsd24Hr
        self.changePercent24Hr = changePercent24Hr
    }
    
}




struct cryptoCoinCapSingleJson: Decodable {
    
    var data: cryptoCoinCapJsonSinglePeriod
    
}


struct cryptoCoinCapJsonSinglePeriod: Decodable {
    
    let id: String?
    let priceUsd: String?
    let symbol: String?
    let marketCapUsd: String?
    let supply: String?
    let maxSupply: String?
    let volumeUsd24Hr: String?
    let changePercent24Hr: String?
   
    
    init(id: String, priceUsd: String, symbol: String, marketCapUsd: String, supply: String, maxSupply: String, volumeUsd24Hr: String, changePercent24Hr: String){
        
        self.id = id
        self.priceUsd = priceUsd
        self.symbol = symbol
        self.marketCapUsd = marketCapUsd
        self.supply = supply
        self.maxSupply = maxSupply
        self.volumeUsd24Hr = volumeUsd24Hr
        self.changePercent24Hr = changePercent24Hr
    }
    
}







