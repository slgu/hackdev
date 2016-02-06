
//
//  NewsViewController.swift
//  hackdev
//
//  Created by GuShenlong on 2/5/16.
//  Copyright © 2016 slgu. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
//api /news/get?datetime=
class NewsViewController: UIViewController {
    @IBOutlet var news_collection: UICollectionView!
    var news_data : JSON = []
    func load_data() {
        print("load_data")
        fetch_news_data(Config.date) { (news_data : JSON) -> Void in
            //if no data is returned just no action
            print(news_data)
            if (news_data.count == 0) {
                return
            }
            self.news_data = news_data
            self.news_collection.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //when recover from outside reload
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "load_data",
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
           news_collection.backgroundColor = UIColor.whiteColor()
        //first load
        load_data()
        news_collection.delegate = self
        news_collection.dataSource = self
        news_collection.backgroundColor = UIColor.blackColor()
        self.navigationItem.title = "Newly Predict Stock"
        
        /* solve nagivation collection view problem */
        self.news_collection.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, self.bottomLayoutGuide.length, 0)
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetch_news_data(date :NSTimeInterval, completion:(JSON) -> Void){
        Alamofire.request(.GET, Config.predict_url + String(date), encoding: .JSON).responseData { response in
            switch response.result {
            case .Success(_):
                let news_data: JSON = JSON(data: response.data!)
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
func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension NewsViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let newCell = collectionView.dequeueReusableCellWithReuseIdentifier("newsCell", forIndexPath: indexPath) as!NewsCollectionViewCell
        newCell.company_name.text = news_data[indexPath.row]["company_name"].string!
        print (news_data[indexPath.row]["pos_neg_value"].double!)
        newCell.pos_neg_value.text = String(news_data[indexPath.row]["pos_neg_value"].double!)
        newCell.company_name.textColor = UIColor.whiteColor()
        newCell.pos_neg_value.textColor = UIColor.whiteColor()
        if news_data[indexPath.row]["pos_neg_value"].double! < 0 {
            newCell.pos_neg_value.backgroundColor = UIColorFromRGB(0x27ae60)
        }
        else {
            newCell.pos_neg_value.backgroundColor = UIColorFromRGB(0xc0392b)
        }
        newCell.layer.borderWidth = 0.3
        newCell.layer.borderColor = UIColor.grayColor().CGColor
        return newCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news_data.count
    }
}

//external name and internal name
extension NewsViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailController: NewsDetailViewController = storyboard.instantiateViewControllerWithIdentifier("NewsDetail") as! NewsDetailViewController
        detailController.last_json_data = news_data[indexPath.row]
        //set data
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}
