//
//  CoinmarketcapAPIService.swift
//  exersice
//
//  Created by Max Deygin on 8/14/18.
//  Copyright © 2018 Max Deygin. All rights reserved.
//

import Foundation
import Moya


enum CoinMarketAPI {
    case getTickers
    case getImage(String)

}

extension CoinMarketAPI: TargetType {
    var baseURL:URL {
        switch self {
        case .getImage:
            return  URL(string: "https://s2.coinmarketcap.com/static/img/coins/128x128/")!
        default:
            return URL(string: "https://api.coinmarketcap.com/v2")!
        }
    }
    var path: String {
        switch self {
        case .getTickers:
            return "/ticker"
        case .getImage(let path):
            return "/\(path).png"
        }
    }
    var method: Moya.Method {
        switch self {
        case _:
            return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getTickers:
                let parameters = ["convert" : "EUR"] as [String : Any]
                return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
       default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getImage:
            return nil
        default:
            return ["Content-Type": "application/json", "Accept": "application/json"]
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
