//
//  GlobalData.swift
//  exersice
//
//  Created by Max Deygin on 8/14/18.
//  Copyright © 2018 Max Deygin. All rights reserved.
//

import Foundation

struct GlobalData: Codable {

    var activeCryptocurrencies: Int
    var activeMarkets: Int
    
    enum DataKeys: String, CodingKey {
        case data
        
    }
    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case activeMarkets = "active_markets"

    }
    
    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: DataKeys.self)
        let dataContainer =
            try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.activeCryptocurrencies = try dataContainer.decode(Int.self, forKey: .activeCryptocurrencies)
        self.activeMarkets = try dataContainer.decode(Int.self, forKey: .activeMarkets)



    }
}
