//
//  NewsDetailViewController.swift
//  hackdev
//
//  Created by GuShenlong on 2/5/16.
//  Copyright © 2016 slgu. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import SwiftyJSON

class NewsDetailViewController: UIViewController {
    @IBOutlet var news_detail_arr: UICollectionView!
    @IBOutlet var bar_chart: LineChartView!
    var news_detail_data :JSON = []
    var last_json_data :JSON =  []
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = NSDate()
        //set delegate
        news_detail_arr.backgroundColor = UIColor.whiteColor()
        news_detail_arr.delegate = self
        news_detail_arr.dataSource = self
        news_detail_arr.backgroundColor = UIColor.blackColor()
        self.navigationItem.title = Config.company_match_rev[last_json_data["company_name"].string!]
        fetch_news_detail_data(date) { (news_data : JSON) -> Void in
            if (news_data.count == 0) {
                return
            }
            self.news_detail_data = news_data
            self.news_detail_arr.reloadData()
            var values: [Double?] = self.news_detail_data["stock_value"].string!.characters.split(",").map {
                item in
                return Double(String(item))
            }.reverse()
            var dataEntries: [ChartDataEntry] = []
            for i in 0..<values.count {
                let dataEntry = ChartDataEntry(value: values[i]!, xIndex: i)
                dataEntries.append(dataEntry)
            }
            let days = ["1.29", "1.30", "1.31", "2.1", "2.2", "2.3", "2.4", "2.5"]
            let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "stock price")
            let chartData = LineChartData(xVals: days, dataSet: chartDataSet)
            self.bar_chart.data = chartData
            // Do any additional setup after loading the view.
        }
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func fetch_news_detail_data(date :NSDate, completion:(JSON) -> Void){
       
        Alamofire.request(.GET,  Config.news_detail_url + String(date.timeIntervalSince1970) + "&company_name=" +  last_json_data["company_name"].string!, encoding: .JSON).responseData { response in
            switch response.result {
            case .Success(_):
                let news_data: JSON = JSON(data: response.data!)
                print(news_data)
                completion(news_data)
            case .Failure(let error):
                print(error)
            }
        }
    }
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension NewsDetailViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let newCell = collectionView.dequeueReusableCellWithReuseIdentifier("newsDetailCell", forIndexPath: indexPath) as!
            NewsDetailCollectionViewCell
        //return format {"company_name": "stock_value":[], "news":["title": "url"]"}"
        newCell.title.text = news_detail_data["news"][indexPath.row]["title"].string!
        newCell.title.textColor = UIColor.whiteColor()
        newCell.title.numberOfLines = 2
        newCell.layer.borderWidth = 0.3
        newCell.layer.borderColor = UIColor.grayColor().CGColor
        return newCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news_detail_data["news"].count
    }
}

//external name and internal name
extension NewsDetailViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let webController: WebViewController = storyboard.instantiateViewControllerWithIdentifier("webView") as! WebViewController
        //set data
        webController.urlstr = news_detail_data["news"][indexPath.row]["url"].string!
        self.navigationController?.pushViewController(webController, animated: true)
    }
}