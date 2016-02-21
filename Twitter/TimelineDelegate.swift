//
//  TimelineDelegate.swift
//  Twitter
//
//  Created by Charles Yeh on 2/20/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

class TimelineDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet]?
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell") as! TimelineCell
        if let tweet = tweets?[indexPath.row] {
            if tweet.retweeted {
                cell.retweetedLabel.text = "() retweeted"
            }
            cell.nameLabel.text = tweet.user.name
            cell.screenNameLabel.text = "@\(tweet.user.screenName)"
            cell.tweetLabel.text = tweet.text
            
            cell.profileImageView.setImageWithURL(
                NSURL(fileURLWithPath: tweet.user.profileImage))
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tweets?.count ?? 0
    }
}