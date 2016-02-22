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
        TwitterClient.sharedInstance.loginWithCompletion { (user, error) -> Void in
            
            if user != nil {
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                // TODO: error
            }
        }
    }
}
