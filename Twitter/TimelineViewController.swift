//
//  ViewController.swift
//  Twitter
//
//  Created by Charles Yeh on 2/15/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    // UI
    @IBOutlet weak var timelineTableView: UITableView!
    
    // UI models
    var timelineDelegate: TimelineDelegate?
    
    @IBAction func onSignOutClick(sender: AnyObject) {
        signOut()
    }
    
    func signOut() {
        TwitterClient.currentUser = nil
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func loadData(refreshControl: UIRefreshControl? = nil) {
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json?count=20", parameters: nil,
            success: { (operation: NSURLSessionDataTask!, response: AnyObject!) -> Void in
                
                NSLog("Loaded tweets")
                if let tweets = response as? NSArray {
                    let convertedTweets = tweets.map({ (tweet) -> Tweet in
                        Tweet(fromAPIResponse: tweet)
                    })
                    self.timelineDelegate!.tweets = convertedTweets
                    self.timelineTableView.reloadData()
                }
                
                if let refreshControl = refreshControl {
                    refreshControl.endRefreshing()
                }
                
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                NSLog("Failed to get current user \(error)")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timelineDelegate = TimelineDelegate(vc: self)
        timelineTableView.delegate = timelineDelegate
        timelineTableView.dataSource = timelineDelegate
        
        timelineTableView.estimatedRowHeight = 100
        timelineTableView.rowHeight = UITableViewAutomaticDimension
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "loadData:", forControlEvents: UIControlEvents.ValueChanged)
        timelineTableView.insertSubview(refreshControl, atIndex: 0)
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let segueIdentifier = segue.identifier {
            if segueIdentifier == "detailSegue" {
                // view tweet details
                let cell = sender as! TimelineCell
                let indexPath = timelineTableView.indexPathForCell(cell)
                
                let vc = segue.destinationViewController as! TweetDetailsViewController
                
                vc.setTweet(timelineDelegate!.tweets![indexPath!.row])
                
            } else if segueIdentifier == "tweetSegue" {
                // new tweet
            } else if segueIdentifier == "replySegue" {
                let tweet = sender as! Tweet
                
                NSLog("\(segue.destinationViewController)")
                let vc = segue.destinationViewController as! TweetViewController
                vc.setReply(tweet.user.screenName)
            }
        }
    }
}

