//
//  CoinList.swift
//  CryptoVote
//
//  Created by Sharapov on 11/8/23.
//  Copyright © 2023 Muzaffar Sharapov. All rights reserved.
//

import Foundation
import UIKit

// used for API calls to List out the price symbol etc of cryptos
struct CoinList: Codable {
    
    var id: String
    var name: String
    var symbol: String
    var priceUSD: String?
    
}
