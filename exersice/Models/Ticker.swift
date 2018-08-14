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
    
    var price : Double
    var volume24h : Double?
    var marketCap : Double?
    var percentChange1h : Double?
    var percentChange24h : Double?
    var percentChange7d : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case price
        case volume24h = "volume_24h"
        case marketCap = "market_cap"
        case percentChange1h = "percent_change_1h"
        case percentChange24h = "percent_change_24h"
        case percentChange7d = "percent_change_7d"
    }
}

struct Ticker: Codable {
    
    var id : Int = 0
    var name : String
    var symbol : String?
    var quotes : [Quote]?
    var usdQuote: Quote?
    var eurQuote: Quote?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case quotes
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        symbol = try? container.decode(String.self, forKey: .symbol)
        
        if let dictionary: [String: Quote] = try? container.decode([String: Quote].self, forKey: .quotes) {
            for key in dictionary.keys {
                if key == "USD", let quote = dictionary[key] {
                    usdQuote = quote
                }
                if key == "EUR", let quote = dictionary[key] {
                    eurQuote = quote
                }
            }
        }
    }
}

extension Ticker {
    
    struct Batch: Codable {
        
        var tickers: [Ticker] = []
        
        init() {}
        
        enum CodingKeys: String, CodingKey {
            case tickers = "data"
        }
        
        init(from decoder:Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            if let dictionary: [String: Ticker] = try? container.decode([String: Ticker].self, forKey: .tickers) {
                for key in dictionary.keys {
                    if let ticker = dictionary[key] {
                        tickers.append(ticker)
                    }
                }
            }
        }
    }
}


