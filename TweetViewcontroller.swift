//
//  TweetViewController.swift
//  Twitter
//
//  Created by Charles Yeh on 2/21/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var retweetedImageView: UIImageView!
    @IBOutlet weak var textLabel: UITextView!
    
    var replyName: String?
    
    override func viewDidLoad() {
        if let user = TwitterClient.currentUser {
            nameLabel.text = user.name
            screenNameLabel.text = user.screenName
            profileImageView.setImageWithURL(NSURL(string: user.profileImage)!)
        }
        
        if let screenName = replyName {
            textLabel.text = "@\(screenName) "
        }
        
        textLabel.becomeFirstResponder()
    }
    
    func setReply(screenName: String) {
        replyName = screenName
    }
    
    @IBAction func onTweetClick(sender: AnyObject) {
        
        let params = NSDictionary(dictionary: ["status" : textLabel.text])
        
        TwitterClient.sharedInstance.POST("1.1/statuses/update.json", parameters: params,
            success: { (operation: NSURLSessionDataTask!, response: AnyObject!) -> Void in
            
                NSLog("Tweeted")
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                
                NSLog("Failed to tweet \(error)")
        })

        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}