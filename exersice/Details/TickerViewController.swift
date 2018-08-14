//
//  DynamicksViewController.swift
//  exersice
//
//  Created by Max Deygin on 8/14/18.
//  Copyright © 2018 Max Deygin. All rights reserved.
//

import UIKit

class TickerViewController : UIViewController {
    var ticker:Ticker!
    
    @IBOutlet weak var hours1label: UILabel!
    @IBOutlet weak var hours24Label: UILabel!
    @IBOutlet weak var days7Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Currency changes"
        setupUI()
    }
    func setupUI() {
        guard let eurQuote = ticker.eurQuote else { return }
        
        
        hours1label.text = String(format: "%.1f%%", eurQuote.percentChange1h ?? 0.0)
        hours24Label.text = String(format: "%.1f%%", eurQuote.percentChange24h ?? 0.0)
        days7Label.text = String(format: "%.1f%%", eurQuote.percentChange7d ?? 0.0)
    }
}

