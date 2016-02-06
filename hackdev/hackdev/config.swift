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
    static let host = "http://localhost:8888"
    static let predict_url = host + "/predict/push?datetime="
    static let news_detail_url = host + "/news/get?datetime="
    static var alertflag = true
    //needed to fix to store locally
}