//
//  ViewController.swift
//  hackdev
//
//  Created by GuShenlong on 2/5/16.
//  Copyright © 2016 slgu. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "back_http:", userInfo: nil, repeats: true)
        timer.fire()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //every 5 second check DB
    func back_http(timer:NSTimer) {
        print (Config.predict_url + String(Config.date))
        if (Config.alertflag == true) {
            Alamofire.request(.GET, Config.predict_url + String(Config.date), encoding: .JSON).responseData { response in
                switch response.result {
                case .Success(_):
                    let notification = UILocalNotification()
                    notification.alertBody = "You have a new stock recommendation" // text that will be displayed in the notification
                    notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
                    notification.soundName = UILocalNotificationDefaultSoundName // play default sound
                    notification.userInfo = ["UUID": "asdasdasdasd"] // assign a unique identifier to the notification so that we can retrieve it later
                    notification.category = "TODO_CATEGORY"
                        UIApplication.sharedApplication().scheduleLocalNotification(notification)
                        //reset time
                    Config.alertflag = false
                case .Failure(let error):
                    print(error)
                }
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

