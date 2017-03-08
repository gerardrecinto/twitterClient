//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 2/26/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "6cz5KxVG6tWiR4CgBq2gMNBS0", consumerSecret: "VytDDUNkMRiGF7h2AlapBQTuWjh1EFMiDR5tHs0Ml4fUN8jU7Z")
 
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        let client = TwitterClient.sharedInstance
        loginSuccess = success
        loginFailure = failure
        
        client?.deauthorize()
        client?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            print("Received token")
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }, failure: { (error: Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })

    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.currentAccount(success: { (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) -> () in
                self.loginFailure?(error)
            })
        }, failure: { (error: Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })

    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            print("getmethod")
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
        })
        
    }

  
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            success(user)

        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
        
    }
  
  func like(id: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
    post("1.1/favorites/create.json?id=" + String(id), parameters: ["id":id], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
      let dict = response as! NSDictionary
      let tweet = Tweet(dictionary: dict)
      success(tweet)
    }) { (task: URLSessionDataTask?, error: Error) in
      print(error.localizedDescription)
    }
  }
  
  
  func unlike(id: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()){
    post("1.1/favorites/destroy.json?id=" + String(id), parameters: ["id":id], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
      let dict = response as! NSDictionary
      let tweet = Tweet(dictionary: dict)
      success(tweet)
    }) { (task: URLSessionDataTask?, error: Error) in
      print(error.localizedDescription)
    }
  }
  
  func retweet(id: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()){
    post("1.1/statuses/retweet/\(id).json", parameters: ["id":id], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
      let dict = response as! NSDictionary
      let tweet = Tweet(dictionary: dict)
      success(tweet)
    }) { (task: URLSessionDataTask?, error: Error) in
      print(error.localizedDescription)
    }
    
  }
  
  func unretweet(id: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()){
    post("1.1/statuses/unretweet/\(id).json", parameters: ["id":id], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
      let dict = response as! NSDictionary
      let tweet = Tweet(dictionary: dict)
      success(tweet)
    }) { (task: URLSessionDataTask?, error: Error) in
      print(error.localizedDescription)
    }
    
  }


      }
