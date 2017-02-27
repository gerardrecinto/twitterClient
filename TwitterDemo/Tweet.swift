//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 2/26/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var tagline: NSString?
    var user: User?
    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var favorited: Bool
    var retweeted: Bool
    
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? NSString
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString) as NSDate?
        }
        
        self.user = User(dictionary: dictionary["user"] as! NSDictionary)
        print("username: " + String(describing: user?.name as? String))
        self.name = user?.name
        self.screenname = user?.screenname
        self.profileUrl = user?.profileUrl as NSURL?
        self.tagline = user?.tagline
        
        self.favorited = dictionary["favorited"] as! Bool
        self.retweeted = dictionary["retweeted"] as! Bool
        
    }


class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
    var tweets = [Tweet]()
    
    for dictionary in dictionaries{
        let tweet = Tweet(dictionary: dictionary)
        tweets.append(tweet)
    }
    return tweets
}
    }
