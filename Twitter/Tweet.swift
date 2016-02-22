//
//  Tweet.swift
//  Twitter
//
//  Created by Charles Yeh on 2/20/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

struct Tweet {
    var retweeted: Bool
    var text: String
    var createdAt: NSDate?
    var retweetCount: Int
    var favoriteCount: Int
    
    var user: TwitterUser
    
    init(fromAPIResponse response: AnyObject) {
        let tweet = response as! NSDictionary
        
        retweeted = tweet["retweeted"] as! Bool
        text = tweet["text"] as! String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
        
        let createdAtString = tweet["created_at"]! as! String
        createdAt = formatter.dateFromString(
            createdAtString)
        
        retweetCount = tweet["retweet_count"] as! Int
        favoriteCount = tweet["favorite_count"] as! Int
        
        user = TwitterUser(fromAPIResponse: tweet["user"]!)
        
    }
}