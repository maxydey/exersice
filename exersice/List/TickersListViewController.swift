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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        viewModel.tickers.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: TickerCell.self), cellType: TickerCell.self)) {(row, ticker, cell) in
                
                cell.titleLabel.text = ticker.name
                if let symbol = ticker.symbol {
                    cell.symbolLabel.text = "(\(symbol))"
                }
                cell.priceLabel.text =  String(format: "%.1f", ticker.usdQuote?.price ?? 0.0)
                
                _ = cell.disposeBag.insert(
                self.viewModel.icon(for: ticker).subscribe(onNext: { (image) in
                    cell.coinIconButton.setImage(image, for: .normal)
                }))
        }.disposed(by: viewModel.disposeBag)
    }
}

