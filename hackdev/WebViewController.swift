//
//  WebViewController.swift
//  hackdev
//
//  Created by GuShenlong on 2/5/16.
//  Copyright © 2016 slgu. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet var webview: UIWebView!
    var urlstr: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL (string: urlstr);
        let requestObj = NSURLRequest(URL: url!);
        webview.loadRequest(requestObj);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
