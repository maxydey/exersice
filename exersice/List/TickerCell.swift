//
//  TickerCell.swift
//  exersice
//
//  Created by Max Deygin on 8/14/18.
//  Copyright © 2018 Max Deygin. All rights reserved.
//

import UIKit
import RxSwift

class TickerCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var coinIconButton: UIButton!
    
    override func awakeFromNib() {
        
    }
    
    @IBAction func imageTap(_ sender: Any) {
        
    }
    
    
    private (set) open var disposeBag = CompositeDisposable()
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag.dispose()
        disposeBag = CompositeDisposable()
    }
    
    deinit {
        disposeBag.dispose()
    }

}
