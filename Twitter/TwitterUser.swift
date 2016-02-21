//
//  TwitterUser.swift
//  Twitter
//
//  Created by Charles Yeh on 2/20/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

struct TwitterUser {
    var name: String, screenName: String, profileImage: String
    
    init(fromAPIResponse response: AnyObject) {
        let user = response as! NSDictionary
        
        name = user["name"] as! String
        screenName = user["screen_name"] as! String
        profileImage = user["profile_image_url"] as! String
    }
}