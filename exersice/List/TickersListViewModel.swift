//
//  TickersListViewModel.swift
//  exersice
//
//  Created by Max Deygin on 8/14/18.
//  Copyright © 2018 Max Deygin. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Action

class TickersListViewModel : NSObject {
 
    @IBOutlet weak var viewController: TickersListViewController!
    let networkService = NetworkService()
    let disposeBag = DisposeBag()
    
    var tickers = BehaviorSubject<[Ticker]>(value: [])
    var loading = BehaviorSubject<Bool>(value: false)

    override init() {
        super.init()
        self.loadTickers().subscribe().disposed(by: disposeBag)
    }
    
    private func loadTickers() -> Observable<Void> {
        loading.onNext(true)
        return networkService.getTickers()
            .catchError{ _ in Single.just(Ticker.Batch()) }
            .asObservable()
            .do(onNext: { (batch) in
                self.tickers.onNext(batch.tickers)
            }).map{ _ in }
    }
    
    func icon(for ticker: Ticker) -> Observable<UIImage?> {
        
        let path = "\(ticker.id)"
        return networkService.getImage(path:path).asObservable()
    }
}

