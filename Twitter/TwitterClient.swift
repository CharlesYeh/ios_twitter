//
//  TwitterClient.swift
//  Twitter
//
//  Created by Charles Yeh on 2/18/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "8DPEIoXk3NTtTkbt9Tri7UowF"
let twitterConsumerSecret = "rFhlxdoDsHJFtJ1c6fICGVfpdjgwmc9ikAddwNzQ9yYWoRVDMi"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

var _currentUser: TwitterUser?
let currentUserKey = "kCurrentUserKey"

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: TwitterUser?, error: NSError?) -> Void)?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(
                baseURL: twitterBaseURL,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    class var currentUser: TwitterUser? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey)
                if data != nil {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data! as! NSData as NSData!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
                        NSLog("Loaded user")
                        _currentUser = TwitterUser(fromDictionary: dictionary)
                    } catch {
                        NSLog("Failed to deserialize user JSON")
                    }
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            if _currentUser != nil {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions.PrettyPrinted)
                    
                    NSLog("Saved JSON user \(data)")
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch {
                    NSLog("Failed to serialize JSON user")
                }
            } else {
                NSLog("Saved nil user")
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func loginWithCompletion(completion: (user: TwitterUser?, error: NSError?) -> Void) {
        
        TwitterClient
            .sharedInstance
            .fetchRequestTokenWithPath(
                "oauth/request_token",
                method: "GET",
                callbackURL: NSURL(string: "cpdtwitterdemo://oauth"),
                scope: nil,
                success: { (requestToken: BDBOAuth1Credential!) -> Void in
                    NSLog("Got request token")
                    
                    // completion is called by App Delegate
                    self.loginCompletion = completion
                    let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                    UIApplication.sharedApplication().openURL(authURL!)
                }, failure: { (error: NSError!) -> Void in
                    NSLog("Failed to get request token: \(error)")
                    completion(user: nil, error: error)
            })
    }
    
    func openURL(url: NSURL) {
        TwitterClient
            .sharedInstance
            .fetchAccessTokenWithPath(
                "oauth/access_token",
                method: "POST",
                requestToken: BDBOAuth1Credential(queryString: url.query),
                success: ({ (accessToken: BDBOAuth1Credential!) -> Void in
                    TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                    TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil,
                        success: { (operation: NSURLSessionDataTask!, response: AnyObject!) -> Void in
                            
                            NSLog("Loaded user")
                            let user = TwitterUser(fromAPIResponse: response)
                            TwitterClient.currentUser = user
                            
                            self.loginCompletion?(user: user, error: nil)
                        }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                            NSLog("Failed to get current user")
                    })
                }),
                failure: ({ (error: NSError!) -> Void in
                    NSLog("Failed to get access token")
                }))
    }
    
    func retweet(tweet: Tweet, completion: () -> Void) {
        let tweetId = tweet.id
        TwitterClient.sharedInstance.POST("1.1/statuses/retweet/\(tweetId).json", parameters: nil,
            success: { (operation: NSURLSessionDataTask!, response: AnyObject!) -> Void in
                
                NSLog("Retweeted")
                completion()
                
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                
                NSLog("Failed to retweet \(error)")
        })
    }
    
    func unRetweet(tweet: Tweet, completion: () -> Void) {
        let tweetId = tweet.id
        TwitterClient.sharedInstance.POST("1.1/statuses/unretweet/\(tweetId).json", parameters: nil,
            success: { (operation: NSURLSessionDataTask!, response: AnyObject!) -> Void in
                
                NSLog("Unretweeted")
                completion()
                
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                
                NSLog("Failed to unretweet \(error)")
        })
    }
    
    func favorite(tweet: Tweet, completion: () -> Void) {
        let params = NSDictionary(dictionary: [ "id": "\(tweet.id)" ])
        TwitterClient.sharedInstance.POST("1.1/favorites/create.json", parameters: params,
            success: { (operation: NSURLSessionDataTask!, response: AnyObject!) -> Void in
                
                NSLog("Favorited")
                completion()
                
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                
                NSLog("Failed to favorite \(error)")
        })
    }
    
    func unFavorite(tweet: Tweet, completion: () -> Void) {
        let params = NSDictionary(dictionary: [ "id": "\(tweet.id)" ])
        TwitterClient.sharedInstance.POST("1.1/favorites/destroy.json", parameters: params,
            success: { (operation: NSURLSessionDataTask!, response: AnyObject!) -> Void in
                
                NSLog("Unfavorited")
                completion()
                
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                
                NSLog("Failed to unfavorite \(error)")
        })
    }
    
    class func getTweets(endpoint: String, params: NSDictionary?, timelineDelegate: TimelineDelegate, timelineTableView: UITableView, refreshControl: UIRefreshControl?, completion: (() -> Void)?) {
        TwitterClient.sharedInstance.GET("1.1/statuses/\(endpoint).json?count=20", parameters: params,
            success: { (operation: NSURLSessionDataTask!, response: AnyObject!) -> Void in
                
                NSLog("Loaded tweets")
                if let tweets = response as? NSArray {
                    let convertedTweets = tweets.map({ (tweet) -> Tweet in
                        Tweet(fromAPIResponse: tweet)
                    })
                    timelineDelegate.tweets = convertedTweets
                    timelineTableView.reloadData()
                }
                
                if let refreshControl = refreshControl {
                    refreshControl.endRefreshing()
                }
                
                completion?()
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                NSLog("Failed to get current user \(error)")
        })
    }
}
