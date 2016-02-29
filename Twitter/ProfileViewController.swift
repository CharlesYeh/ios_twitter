//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Charles Yeh on 2/26/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var numTweetLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    
    @IBOutlet weak var tweetView: UIView!
    var user: TwitterUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backImageView.setImageWithURL(NSURL(string: user!.backgroundImage)!)
        profileImageView.setImageWithURL(NSURL(string: user!.profileImage)!)
        nameLabel.text = user?.name
        screenNameLabel.text = user?.screenName
        
        numTweetLabel.text = "\(user!.statusesCount)"
        numFollowersLabel.text = "\(user!.followersCount)"
        numFollowingLabel.text = "\(user!.friendsCount)"
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let timeline = storyboard.instantiateViewControllerWithIdentifier("tweetTimeline") as! TimelineViewController
        
        timeline.endpoint = "user_timeline"
        timeline.endpointParams = NSDictionary(dictionary: [ "screen_name": user!.screenName ])
        timeline.view.frame = tweetView.bounds
        tweetView.addSubview(timeline.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
