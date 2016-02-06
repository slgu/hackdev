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
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = NSDate()
        //set delegate
        news_detail_arr.backgroundColor = UIColor.whiteColor()
        news_detail_arr.delegate = self
        news_detail_arr.dataSource = self
        news_detail_arr.backgroundColor = UIColor.blackColor()
        self.navigationItem.title = "Stock/News Detail"
        fetch_news_detail_data(date) { (news_data : JSON) -> Void in
            self.news_detail_data = news_data
            self.news_detail_arr.reloadData()
        }
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let values = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<12 {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "stock price")
        let chartData = LineChartData(xVals: months, dataSet: chartDataSet)
        bar_chart.data = chartData
        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var news_detail_url = "http://localhost:8888/news/get?datetime="
    func fetch_news_detail_data(date :NSDate, completion:(JSON) -> Void){
        Alamofire.request(.GET, self.news_detail_url + String(date.timeIntervalSince1970), encoding: .JSON).responseData { response in
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
        newCell.title.text = news_detail_data[indexPath.row]["title"].string!
        newCell.title.textColor = UIColor.whiteColor()
        newCell.layer.borderWidth = 0.3
        newCell.layer.borderColor = UIColor.grayColor().CGColor
        return newCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news_detail_data.count
    }
}

//external name and internal name
extension NewsDetailViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let webController: WebViewController = storyboard.instantiateViewControllerWithIdentifier("webView") as! WebViewController
        //set data
        webController.urlstr = news_detail_data[indexPath.row]["url"].string!
        self.navigationController?.pushViewController(webController, animated: true)
    }
}