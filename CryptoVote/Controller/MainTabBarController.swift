//
//  CryptoStats.swift
//  CryptoVote
//
//  Created by ZAF on 4/16/19.
//  Copyright © 2019 Muzaffar Sharapov. All rights reserved.
//
//The MainTabBarController is designed to manage the main navigation within the app through a tab bar interface. It customizes the appearance and behavior of the tab bar and the view controllers associated with each tab, providing a structured and user-friendly navigation system within the app.

import UIKit
import Firebase



class MainTabBarController: UITabBarController {
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        if #available(iOS 13.0, *) {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .clear
            view.backgroundColor = UIColor(named: "backgroundColor")
         //   tableView.backgroundColor = UIColor(named: "backgroundColor")
        } else {

        }
        } else {
            print("nochange")
        }

        

        setupTabBar()
       
    }
    

    
    
    func setupTabBar() {

        let listController = createNavController(vc: CryptoList(), selected: #imageLiteral(resourceName: "list"), unselected: #imageLiteral(resourceName: "list"))

        let chatContoller = createNavController(vc: CryptoVote(), selected: #imageLiteral(resourceName: "bars"), unselected: #imageLiteral(resourceName: "bars"))
        let cryptoSettingVC = createNavController(vc: SettingsStackVC(), selected: #imageLiteral(resourceName: "setting_black"), unselected: #imageLiteral(resourceName: "setting_white"))
        
        viewControllers = [listController, chatContoller, cryptoSettingVC]
        
        guard let items = tabBar.items else { return }
        
        guard let tabHome = tabBar.items?[0] else {return}
        tabHome.title = "Crypto List"

        guard let tabVote = tabBar.items?[1] else {return}
        tabVote.title = "Vote"
        guard let tabSettings = tabBar.items?[2] else {return}
        tabSettings.title = "Settings"
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
        }}
    

}




extension UITabBarController {
    
    func createNavController(vc: UIViewController, selected: UIImage, unselected: UIImage) -> UINavigationController {
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselected
        navController.tabBarItem.selectedImage = selected
        UITabBar.appearance().tintColor = UIColor(red: 0.2235, green: 0.5176, blue: 0.4588, alpha: 1.0)
        
        return navController
    }
    
}

