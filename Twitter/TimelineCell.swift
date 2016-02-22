//
//  TimelineCell.swift
//  Twitter
//
//  Created by Charles Yeh on 2/20/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

protocol TimelineCellActioner {
    func setActioner()
}

class TimelineCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var retweetedLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweetModel: Tweet?
    var tweet: Tweet? {
        set(t) {
            TweetUIModel.setButtons(t!, retweetButton: retweetButton, favoriteButton: favoriteButton)
            tweetModel = t
        }
        get {
            return tweetModel
        }
    }
    
    var replyDelegate: UIViewController?
    
    @IBAction func onReply(sender: AnyObject) {
        TweetUIModel.onReply(tweet!, vc: replyDelegate!)
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        TweetUIModel.onRetweet(sender, tweet: self.tweet!, button: retweetButton)
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        TweetUIModel.onFavorite(sender, tweet: self.tweet!, button: favoriteButton)
    }
}