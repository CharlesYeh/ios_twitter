//
//  TimelineDelegate.swift
//  Twitter
//
//  Created by Charles Yeh on 2/20/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

class TimelineDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var parentViewController: UIViewController?
    var tweets: [Tweet]?
    
    init(vc: UIViewController) {
        parentViewController = vc
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        parentViewController?.performSegueWithIdentifier("tweetDetail", sender: indexPath)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell") as! TimelineCell
        if let tweet = tweets?[indexPath.row] {
            if tweet.retweeted {
                cell.retweetedLabel.text = "() retweeted"
            } else {
                cell.retweetImageView.hidden = true
                cell.retweetedLabel.hidden = true
            }
            cell.nameLabel.text = tweet.user.name
            cell.screenNameLabel.text = "@\(tweet.user.screenName)"
            cell.tweetLabel.text = tweet.text
            
            cell.profileImageView.setImageWithURL(
                NSURL(string: tweet.user.profileImage)!)
            
            cell.replyButtonView.tag = indexPath.row
            cell.retweetButtonView.tag = indexPath.row
            cell.likeButtonView.tag = indexPath.row
            
            cell.replyButtonView.addGestureRecognizer(UITapGestureRecognizer(target: parentViewController, action: "onReplyButton:"))
            cell.retweetButtonView.addGestureRecognizer(UITapGestureRecognizer(target: parentViewController, action: "onRetweetButton:"))
            cell.likeButtonView.addGestureRecognizer(UITapGestureRecognizer(target: parentViewController, action: "onLikeButton:"))
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
}