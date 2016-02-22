//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by Charles Yeh on 2/21/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    var tweet: Tweet?
    
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    func setTweet(tweet: Tweet) {
        self.tweet = tweet
    }
    
    @IBAction func onReply(sender: AnyObject) {
        TweetUIModel.onReply(self.tweet!, vc: self)
    }
    
    @IBAction func onNavBarReply(sender: AnyObject) {
        TweetUIModel.onReply(self.tweet!, vc: self)
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        TweetUIModel.onRetweet(sender, tweet: self.tweet!, button: self.retweetButton)
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        TweetUIModel.onFavorite(sender, tweet: self.tweet!, button: self.favoriteButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retweetImageView.hidden = true
        retweetLabel.text = ""
        
        if let tweet = tweet {
            profileImageView.setImageWithURL(NSURL(string: tweet.user.profileImage)!)
            nameLabel.text = tweet.user.name
        
            screenNameLabel.text = tweet.user.screenName
            tweetLabel.text = tweet.text
            // TODO:
            dateLabel.text = ""
            retweetCountLabel.text = "\(tweet.retweetCount)"
            favoriteCountLabel.text = "\(tweet.favoriteCount)"
        }
        
        TweetUIModel.setButtons(self.tweet!, retweetButton: retweetButton, favoriteButton: favoriteButton)
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // this vc only goes to reply only
        let tweet = sender as! Tweet
        
        let vc = segue.destinationViewController as! TweetViewController
        vc.setReply(tweet.user.screenName)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
