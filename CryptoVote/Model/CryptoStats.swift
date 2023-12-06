//
//  CryptoStats.swift
//  CryptoVote
//
//  Created by Sharapov on 11/14/23.
//  Copyright © 2023 Muzaffar Sharapov. All rights reserved.
//
//Description: The CryptoStats struct in Swift is designed to encapsulate data related to cryptocurrencies, particularly for use in an application that interacts with Firebase for data storage and retrieval. This struct is structured to hold and decode cryptocurrency information,  fetched from an external API or a Firebase database.


import Foundation
import UIKit

//posting VOTES in FIREBASE storage

struct CryptoStats:Decodable {
    
    var name: String = ""
    var symbol: String? = ""
    var price_usd: String = ""
    
    
    init(name: String, symbol: String, price_usd: String){
        self.name = name
        self.symbol = symbol
        self.price_usd = price_usd
        

        
    }
    
//    deinit {
//        print("delocatted")
//    }
    
    
}
