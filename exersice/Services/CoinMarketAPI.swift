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
    case getTickers(Bool)
    case getGlobalData
    case getImage(String)

}

extension CoinMarketAPI: TargetType {
    var baseURL:URL {
        switch self {
        case .getImage:
            return  URL(string: "https://s2.coinmarketcap.com/static/img/coins/128x128")!
        default:
            return URL(string: "https://api.coinmarketcap.com/v2")!
        }
    }
    var path: String {
        switch self {
        case .getTickers:
            return "/ticker"
        case .getGlobalData:
            return "/global"
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
        let data:Data
        switch self {
        case .getTickers(let fail):
            
            try! data = Data.init(contentsOf: URL(fileReferenceLiteralResourceName:fail == true ? "failedTickerData.json" : "sampleTickersData.json"))
        case .getGlobalData:
            try! data = Data.init(contentsOf: URL(fileReferenceLiteralResourceName:"sampleGlobalData.json"))
        case .getImage:
            try! data = Data.init(contentsOf: URL(fileReferenceLiteralResourceName:"sampleImage.png"))
        }
       return data
    }
    
    var task: Task {
        switch self {
        case .getTickers:
            let parameters = ["convert" : "EUR", "structure" : "array"] as [String : Any]
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
