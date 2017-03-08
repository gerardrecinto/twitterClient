//
//  User.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 2/26/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: NSString?
    var screenname: NSString?
    var profileUrl: URL?
    var tagline: NSString?
    var dictionary: NSDictionary?
    var coverPhotoUrl: URL?
    var tweetsCount: Int = 0
  var followerCount: Int = 0
  var followingCount: Int = 0
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? NSString
        screenname = dictionary["screen_name"] as? NSString
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString{
            profileUrl = URL(string: profileUrlString)
        } else {
          profileUrl = URL(string: "")
      }
      let coverPhotoUrlString = dictionary["profile_background_image_url_https"] as? String
      if let coverPhotoUrlString = coverPhotoUrlString {
        coverPhotoUrl = URL(string: coverPhotoUrlString)
      } else {
        coverPhotoUrl = URL(string: "")
      }
        tweetsCount = dictionary["statuses_count"] as! Int
        tagline = dictionary["description"] as? NSString
        followerCount = dictionary["followers_count"] as! Int
        followingCount = dictionary["friends_count"] as! Int
    }

    static let userDidLogoutNotification = "UserDidLogout"

    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
            let defaults = UserDefaults.standard
            let userData = defaults.object(forKey: "currentUserData") as? NSData
            if let userData = userData{
                let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                _currentUser = User(dictionary: dictionary)
             }
                
            }
            return _currentUser
        }
        
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
    
}
