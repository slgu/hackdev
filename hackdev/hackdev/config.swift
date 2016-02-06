//
//  config.swift
//  hackdev
//
//  Created by GuShenlong on 2/5/16.
//  Copyright © 2016 slgu. All rights reserved.
//

import Foundation
class Config {
    static var date = NSDate().timeIntervalSince1970 //a date which begins when user opens app
    static let host = "http://52.91.227.244:8888"
    static let predict_url = host + "/predict/push?datetime="
    static let news_detail_url = host + "/news/get?datetime="
    static var alertflag = true
    static let company_match = ["Google":"GOOGL", "Facebook": "FB", "Microsoft": "MSFT", "LinkedIn": "LNKD", "Square": "SQ", "Tableau": "DATA", "WalMart": "WMT", "Best Buy": "BBY", "Control4 Corporation":"CTRL"]
    static let company_match_rev = ["GOOGL":"Google", "FB": "Facebook", "MSFT": "Microsoft", "LNKD": "LinkedIn", "SQ": "Square", "DATA": "Tableau", "WMT": "WalMart", "BBY": "Best Buy", "CTRL":"Control4 Corporation"]
    //needed to fix to store locally
}