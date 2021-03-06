//
//  TimelineDelegate.swift
//  Twitter
//
//  Created by Charles Yeh on 2/20/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit
import AFNetworking

class TimelineDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var parentViewController: UIViewController?
    var tweets: [Tweet]?
    
    init(vc: UIViewController) {
        parentViewController = vc
    }
    
    func initTableView(timelineTableView: UITableView) {
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        
        timelineTableView.estimatedRowHeight = 100
        timelineTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell") as! TimelineCell
        if let tweet = tweets?[indexPath.row] {
            if let name = tweet.retweeterName {
                cell.retweetedLabel.text = "\(name) retweeted"
                cell.retweetImageView.hidden = false
                cell.retweetedLabel.hidden = false
            } else {
                cell.retweetImageView.hidden = true
                cell.retweetedLabel.hidden = true
                cell.retweetImageView.addConstraint(NSLayoutConstraint(item: cell.retweetImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0, constant: 0))
            }
            
            cell.retweetImageView.updateConstraints()
            
            cell.nameLabel.text = tweet.user.name
            cell.screenNameLabel.text = "@\(tweet.user.screenName)"
            cell.tweetLabel.text = tweet.text
            
            let profileImage = NSURL(string: tweet.user.profileImage)!
            
            cell.profileImage.setImageWithURL(profileImage)
            
            cell.tweet = tweet
            cell.replyDelegate = parentViewController
            
            if cell.tapGesture == nil {
                let gr = UITapGestureRecognizer(target: parentViewController, action: "onProfileTap:")
                
                cell.profileImage.userInteractionEnabled = true
                cell.profileImage.addGestureRecognizer(gr)
                cell.tapGesture = gr
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
}