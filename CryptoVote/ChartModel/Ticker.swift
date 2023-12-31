//
//  CoinList.swift
//  CryptoVote
//
//  Created by ZAF on 5/24/19.
//  Copyright © 2019 Muzaffar Sharapov. All rights reserved.
//

import Foundation


struct Ticker: Codable {
    
    var id: String
    var name: String
    var symbol: String
    var rank: String
    var priceUSD: String?
    var priceBTC: String?
    var dayVolumeUSD: String?
    var marketCapUSD: String?
    var availableSupply: String?
    var totalSupply: String?
    var percentChange1h: String?
    var percentChange24h: String?
    var percentChange7d: String?
    var lastUpdated: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case rank
        case priceUSD         = "price_usd"
        case priceBTC         = "price_btc"
        case dayVolumeUSD     = "24h_volume_usd"
        case marketCapUSD     = "market_cap_usd"
        case availableSupply  = "available_supply"
        case totalSupply      = "total_supply"
        case percentChange1h  = "percent_change_1h"
        case percentChange24h = "percent_change_24h"
        case percentChange7d  = "percent_change_7d"
        case lastUpdated      = "last_updated"
    }
}







