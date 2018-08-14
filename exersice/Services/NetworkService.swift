//
//  NetworkService.swift
//  exersice
//
//  Created by Max Deygin on 8/14/18.
//  Copyright © 2018 Max Deygin. All rights reserved.
//

import Foundation
import RxSwift
import Moya


enum NetworkError: Swift.Error {
    case noData(String)
}

class NetworkService {
    let provider:MoyaProvider<CoinMarketAPI>
    let jsonDecoder = JSONDecoder()
    let disposeBag = DisposeBag()
    
    convenience init() {
        self.init(testing: false)
    }
    init(testing: Bool) {
        provider = MoyaProvider<CoinMarketAPI>(stubClosure: testing ? MoyaProvider.immediatelyStub : MoyaProvider.neverStub)
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
    }

    
    func getTickers() -> Single<Ticker.Batch> {
        return provider.rx.request(.getTickers(false))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(Ticker.Batch.self, using: jsonDecoder)
    }
    
        
    func getGlobalData() -> Single<GlobalData> {
        return provider.rx.request(.getGlobalData)
            .filterSuccessfulStatusAndRedirectCodes()
            .map(GlobalData.self, using: jsonDecoder)
    }
    
    func getImage(path: String) -> Single<Image?> {
        return provider.rx.request(.getImage(path))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapImage()
    }
}

internal extension NetworkService {
    //for tests only
    func getTickersAndFail() -> Single<Ticker.Batch> {
        return provider.rx.request(.getTickers(true))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(Ticker.Batch.self, using: jsonDecoder)
    }
}
