//
//  ViewController.swift
//  Twitter
//
//  Created by Charles Yeh on 2/15/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

    var tweets: [Tweet] = []
    
    // UI
    @IBOutlet weak var timelineTableView: UITableView!
    
    // UI models
    var timelineDelegate: TimelineDelegate?
    
    // models
    var user: TwitterUser?
    
    @IBAction func onSignOutClick(sender: AnyObject) {
        signOut()
        
    }
    
    func signOut() {
        
    }
    
    func user(apiResponse: AnyObject) {
        self.user = TwitterUser(fromAPIResponse: apiResponse)
    }
    
    func loadData() {
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil,
            success: { (operation: NSURLSessionDataTask!, response: AnyObject!) -> Void in
                
                NSLog("Loaded tweets")
                if let tweets = response as? NSArray {
                    let convertedTweets = tweets.map({ (tweet) -> Tweet in
                        Tweet(fromAPIResponse: tweet)
                    })
                    self.timelineDelegate!.tweets = convertedTweets
                    self.timelineTableView.reloadData()
                }
                
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                NSLog("Failed to get current user")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timelineDelegate = TimelineDelegate()
        timelineTableView.delegate = timelineDelegate
        timelineTableView.dataSource = timelineDelegate
        
        timelineTableView.estimatedRowHeight = 100
        timelineTableView.rowHeight = UITableViewAutomaticDimension
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

