//
//  TimelineCell.swift
//  Twitter
//
//  Created by Charles Yeh on 2/20/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var retweetedLabel: UILabel!
}