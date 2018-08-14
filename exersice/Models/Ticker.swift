//
//  Ticker.swift
//  exersice
//
//  Created by Max Deygin on 8/14/18.
//  Copyright © 2018 Max Deygin. All rights reserved.
//

import Foundation

/*"id": 1,
 "name": "Bitcoin",
 "symbol": "BTC",
 "website_slug": "bitcoin",
 "rank": 1,
 "circulating_supply": 17008162.0,
 "total_supply": 17008162.0,
 "max_supply": 21000000.0,
 "quotes": {
 "USD": {
 "price": 9024.09,
 "volume_24h": 8765400000.0,
 "market_cap": 153483184623.0,
 "percent_change_1h": -2.31,
 "percent_change_24h": -4.18,
 "percent_change_7d": -0.47
 }
 },
 "last_updated": 1525137271*/

struct Quote : Codable {
    
    var name : String?
//    var price : Double?
//    var volume24h : Double?
//    var marketCap : Double?
//    var percentChange1h : Double?
//    var percentChange24h : Double?
//    var percentChange7d : Double?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct Ticker: Codable {
    
    var id : Int?
    var name : String?
    var symbol : String?
    var websiteSlug : String?
    var rank : Int?
    var circulatingSupply : Double?
    var totalSuply : Double?
    var maxSuply : Double?
    var quotes : [Quote]?
    var lastUpaded: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case websiteSlug = "website_slug"
        case rank
        case circulatingSupply = "circulating_supply"
        case totalSuply = "total_supply"
        case maxSuply = "max_supply"
        case quotes
        case lastUpaded = "last_updated"
    }
}
