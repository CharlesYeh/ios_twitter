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
        // TODO: sign out
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func user(apiResponse: AnyObject) {
        self.user = TwitterUser(fromAPIResponse: apiResponse)
    }
    
    func loadData(refreshControl: UIRefreshControl? = nil) {
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
                
                if let refreshControl = refreshControl {
                    dispatch_async(dispatch_get_main_queue(), {
                        refreshControl.endEditing(true)
                    })
                }
                
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                NSLog("Failed to get current user")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timelineDelegate = TimelineDelegate(vc: self)
        timelineTableView.delegate = timelineDelegate
        timelineTableView.dataSource = timelineDelegate
        
        timelineTableView.estimatedRowHeight = 200
        timelineTableView.rowHeight = UITableViewAutomaticDimension
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "loadData:", forControlEvents: UIControlEvents.ValueChanged)
        timelineTableView.insertSubview(refreshControl, atIndex: 0)
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func onReplyButton(gesture: UIGestureRecognizer) {
        performSegueWithIdentifier("replySegue", sender: gesture.view!)
    }
    
    func onRetweetButton(gesture: UIGestureRecognizer) {
        performSegueWithIdentifier("retweetSegue", sender: gesture.view!)
    }
    
    func onLikeButton(gesture: UIGestureRecognizer) {
        // TODO: like
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let segueIdentifier = segue.identifier {
            if segueIdentifier == "tweetSegue" {
                let vc = segue.destinationViewController as! TweetViewController
                vc.user(user!)
            } else if segueIdentifier == "replySegue" {
                let vc = segue.destinationViewController as! TweetViewController
                vc.user(user!)
                // TODO: reply stuff
            } else if segueIdentifier == "retweetSegue" {
                let vc = segue.destinationViewController as! TweetViewController
                vc.user(user!)
                // TODO: retweet stuff
            }
        }
    }
}

