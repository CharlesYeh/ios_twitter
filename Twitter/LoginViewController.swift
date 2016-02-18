//
//  LoginViewController.swift
//  Twitter
//
//  Created by Charles Yeh on 2/18/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {
    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient
            .sharedInstance
            .fetchRequestTokenWithPath(
                "oauth/request_token",
                method: "GET",
                callbackURL: NSURL(string: "cptwitterdemo://oauth"),
                scope: nil,
                success: { (requestToken: BDBOAuth1Credential!) -> Void in
                    
                    NSLog("Got request token")
                    
                    let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                    UIApplication.sharedApplication().openURL(authURL!)
                    
                }, failure: { (error: NSError!) -> Void in
                    
                    NSLog("Failed to get request token: \(error)")
                    
                })
    }
}
