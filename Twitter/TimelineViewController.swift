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
    var hamburgerViewController: HamburgerViewController?
    var endpoint: String = "home_timeline" {
        didSet(newValue) {
            if newValue != "user_timeline" {
                endpointParams = nil
            }
        }
    }
    var endpointParams: NSDictionary?
    
    @IBAction func onSignOutClick(sender: AnyObject) {
        signOut()
    }
    
    func signOut() {
        TwitterClient.currentUser = nil
        // in hamburger content view
        
        hamburgerViewController!
            .dismissViewControllerAnimated(false, completion: nil)
    }
    
    func onProfileTap(sender: UIGestureRecognizer) {
        
        let cell = sender.view!.superview?.superview as! TimelineCell
        performSegueWithIdentifier("profileSegue", sender: cell.tweet as? AnyObject)
    }
    
    func loadData(refreshControl: UIRefreshControl? = nil) {
        if timelineDelegate != nil {
            TwitterClient.getTweets(endpoint, params: endpointParams, timelineDelegate: timelineDelegate!, timelineTableView: timelineTableView, refreshControl: refreshControl, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timelineDelegate = TimelineDelegate(vc: self)
        timelineDelegate!.initTableView(timelineTableView)
        
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
                
                let vc = segue.destinationViewController as! TweetViewController
                vc.setReply(tweet.user.screenName)
            } else if segueIdentifier == "profileSegue" {
                let vc = segue.destinationViewController as! ProfileViewController
                vc.user = (sender as! Tweet).user
            }
        }
    }
}

