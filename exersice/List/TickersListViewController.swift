//
//  ViewController.swift
//  exersice
//
//  Created by Max Deygin on 8/14/18.
//  Copyright © 2018 Max Deygin. All rights reserved.
//

import UIKit
import RxSwift

class TickersListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewModel: TickersListViewModel!
    
    @IBOutlet weak var cryptocurenciesNumberLabel: UILabel!
    @IBOutlet weak var marketsNumberLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTableView()
    }
    
    func  setupUI() {
        viewModel.title.asObservable().bind(to: self.rx.title).disposed(by:viewModel.disposeBag)
        
        viewModel.globalData
            .map{ "\($0.activeCryptocurrencies)" }
            .bind(to: cryptocurenciesNumberLabel.rx.text)
            .disposed(by:viewModel.disposeBag)
        
        viewModel.globalData
            .map{ "\($0.activeMarkets)" }
            .bind(to: marketsNumberLabel.rx.text)
            .disposed(by: viewModel.disposeBag)
        
    }
    
    func setupTableView() {
        viewModel.tickers.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: TickerCell.self), cellType: TickerCell.self)) {[unowned self] (row, ticker, cell) in
                
                cell.titleLabel.text = ticker.name
                if let symbol = ticker.symbol {
                    cell.symbolLabel.text = "(\(symbol))"
                }
                cell.priceLabel.text =  String(format: "$%.1f", ticker.usdQuote?.price ?? 0.0)
                
                 cell.coinIconButton.rx.bind(to: self.viewModel.titleAction, input: ticker)
                
                _ = cell.disposeBag.insert(
                    self.viewModel.icon(for: ticker).bind(to: cell.coinIconButton.rx.image()))}
            .disposed(by: viewModel.disposeBag)
        
        tableView.rx.modelSelected(Ticker.self).bind(to: viewModel.openTickerAction.inputs).disposed(by: viewModel.disposeBag)
        
        tableView.rx.itemSelected.asObservable().bind { [weak self] (indexPath) in
            guard let strongSelf = self else { return }
            strongSelf.tableView.deselectRow(at: indexPath, animated: true)
            }.disposed(by: viewModel.disposeBag)
        
    }
    
  
}

