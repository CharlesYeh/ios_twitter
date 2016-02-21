//
//  TweetViewController.swift
//  Twitter
//
//  Created by Charles Yeh on 2/21/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    var user: TwitterUser?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var retweetedImageView: UIImageView!
    @IBOutlet weak var textLabel: UITextView!
    
    override func viewDidLoad() {
        nameLabel.text = user!.name
        screenNameLabel.text = user!.screenName
        profileImageView.setImageWithURL(NSURL(string: user!.profileImage)!)
    }
    
    func user(user: TwitterUser) {
        self.user = user
    }
}