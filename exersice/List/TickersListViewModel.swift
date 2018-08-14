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
    var title = BehaviorSubject<String>(value: "Tickers")

    override init() {
        super.init()
        self.loadTickers().subscribe().disposed(by: disposeBag)
    }
    
    private func loadTickers() -> Observable<Void> {
        loading.onNext(true)
        return networkService.getTickers()
            .catchError{ _ in Single.just(Ticker.Batch()) }
            .asObservable()
            .map({ (batch) -> [Ticker] in
                return batch.tickers.sorted(by: { (item1, item2) -> Bool in
                    if let quote1 = item1.usdQuote, let quote2 = item2.usdQuote {
                        return quote1.price > quote2.price
                    }
                    return false
                })
            })
            .do(onNext: { (tickers) in
                self.tickers.onNext(tickers)
            }).map{ _ in }
    }
    
    func icon(for ticker: Ticker) -> Observable<UIImage?> {
        
        let path = "\(ticker.id)"
        return networkService.getImage(path:path).asObservable()
    }
    
    lazy var openTickerAction = Action<Ticker, Void> {
        [weak self] ticker in
        guard let strongSelf = self,
            let navigationController = strongSelf.viewController.navigationController
            else { return .empty() }
        
        let viewController = UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: String(describing: TickerViewController.self)) as! TickerViewController
        viewController.ticker = ticker
        navigationController.pushViewController(viewController, animated: true)
        return .empty()
    }
    
    lazy var titleAction = Action<Ticker, Void> {
        [weak self] ticker in
        guard let strongSelf = self else { return .empty() }
        strongSelf.title.onNext(ticker.name )
        return .empty()
    }
}

