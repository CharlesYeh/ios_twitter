//
//  TwitterClient.swift
//  Twitter
//
//  Created by Charles Yeh on 2/18/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "8DPEIoXk3NTtTkbt9Tri7UowF"
let twitterConsumerSecret = "rFhlxdoDsHJFtJ1c6fICGVfpdjgwmc9ikAddwNzQ9yYWoRVDMi"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(
                baseURL: twitterBaseURL,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
}
