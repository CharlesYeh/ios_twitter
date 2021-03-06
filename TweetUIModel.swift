//
//  TweetUIModel.swift
//  Twitter
//
//  Created by Charles Yeh on 2/21/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

class TweetUIModel: NSObject {
    class func onReply(tweet: Tweet, vc: UIViewController) {
        vc.performSegueWithIdentifier("replySegue", sender: tweet)
    }
    
    class func loginSegue() -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let hamburgerNC = storyboard.instantiateViewControllerWithIdentifier("HamburgerViewController") as! HamburgerViewController
        let menuVC = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        
        hamburgerNC.menuViewController = menuVC
        
        return hamburgerNC
    }
    
    class func setButtons(tweet: Tweet, retweetButton: UIButton, favoriteButton: UIButton) {
        
        if tweet.retweeted {
            retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: .Normal)
        } else {
            retweetButton.setImage(UIImage(named: "retweet-action"), forState: .Normal)
        }
        
        if tweet.favorited {
            favoriteButton.setImage(UIImage(named: "like-action-on"), forState: .Normal)
        } else {
            favoriteButton.setImage(UIImage(named: "like-action"), forState: .Normal)
        }
    }
    
    class func onRetweet(sender: AnyObject, tweet: Tweet, button: UIButton) {
        if tweet.retweeted {
            TwitterClient.sharedInstance.unRetweet(tweet, completion: { () -> Void in
                
                tweet.setRetweet(false)
                button.setImage(UIImage(named: "retweet-action"), forState: .Normal)
            })
        } else {
            TwitterClient.sharedInstance.retweet(tweet, completion: { () -> Void in
                
                tweet.setRetweet(true)
                button.setImage(UIImage(named: "retweet-action-on"), forState: .Normal)
            })
        }
    }
    
    class func onFavorite(sender: AnyObject, tweet: Tweet, button: UIButton) {
        NSLog("favor: \(tweet.favorited)")
        if tweet.favorited {
            TwitterClient.sharedInstance.unFavorite(tweet, completion: { () -> Void in
                
                tweet.setFavorite(false)
                NSLog("favor2: \(tweet.favorited)")
                
                button.setImage(UIImage(named: "like-action"), forState: .Normal)
            })
        } else {
            TwitterClient.sharedInstance.favorite(tweet, completion: { () -> Void in
                
                tweet.setFavorite(true)
                NSLog("favor2: \(tweet.favorited)")
                button.setImage(UIImage(named: "like-action-on"), forState: .Normal)
            })
        }
    }
}