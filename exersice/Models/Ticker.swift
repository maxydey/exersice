//
//  Ticker.swift
//  exersice
//
//  Created by Max Deygin on 8/14/18.
//  Copyright © 2018 Max Deygin. All rights reserved.
//

import Foundation

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
    
    var usdQuote: Quote?
    var eurQuote: Quote?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case usdQuote = "USD"
        case eurQuote = "EUR"


    }
    enum NestedQuotesKeys: String, CodingKey {
      case quotes
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        symbol = try? container.decode(String.self, forKey: .symbol)
        
        let rootContainer = try decoder.container(keyedBy: NestedQuotesKeys.self)
        let dataContainer = try rootContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .quotes)

        usdQuote = try? dataContainer.decode(Quote.self, forKey: .usdQuote)
        eurQuote = try? dataContainer.decode(Quote.self, forKey: .eurQuote)
        
    }
}

extension Ticker {
    
    struct Batch: Codable {
        
        var tickers: [Ticker] = []
        var metadata: Metadata?
        
        init() {}
        
        enum CodingKeys: String, CodingKey {
            case tickers = "data"
            case metadata
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
            
            metadata = try? container.decode(Metadata.self, forKey: .metadata)

            if let error = metadata?.error {
                throw NetworkError.noData(error)
            }
        }
    }
}

struct Metadata: Codable {
    
    var error:String?
    var timestamp:Date?
    
    enum CodingKeys:String, CodingKey {
        case error
        case timestamp
    }
}


