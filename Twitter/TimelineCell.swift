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
    
    var tweet: Tweet?
    
    @IBAction func onReply(sender: AnyObject) {
        
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        
    }
}