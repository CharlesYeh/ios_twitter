//
//  TwitterUser.swift
//  Twitter
//
//  Created by Charles Yeh on 2/20/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

struct TwitterUser {
    var name: String, screenName: String, backgroundImage: String, profileImage: String
    var followersCount: Int, statusesCount: Int, friendsCount: Int
    
    var dictionary: NSDictionary
    
    init(fromAPIResponse response: AnyObject) {
        let user = response as! NSDictionary
        self.init(fromDictionary: user)
    }
    
    init(fromDictionary data: NSDictionary) {
        
        name = data["name"] as! String
        screenName = data["screen_name"] as! String
        backgroundImage = data["profile_background_image_url"] as! String
        profileImage = data["profile_image_url"] as! String
        
        followersCount = data["followers_count"] as! Int
        statusesCount = data["statuses_count"] as! Int
        friendsCount = data["friends_count"] as! Int
        
        dictionary = data
    }
}