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
    
    var dictionary: NSDictionary
    
    init(fromAPIResponse response: AnyObject) {
        let user = response as! NSDictionary
        self.init(fromDictionary: user)
    }
    
    init(fromDictionary data: NSDictionary) {
        name = data["name"] as! String
        screenName = data["screen_name"] as! String
        profileImage = data["profile_image_url"] as! String
        
        dictionary = data
    }
}