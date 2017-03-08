//
//  TweetDetailViewController.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 2/28/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
  @IBOutlet weak var screennameLabel: UILabel!
  @IBOutlet weak var photoButton: UIButton!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var retweetLabel: UILabel!
  @IBOutlet weak var likeCountLabel: UILabel!
  @IBOutlet weak var likeLabel: UILabel!
  @IBOutlet weak var replyButton: UIButton!
  @IBOutlet weak var retweetButton: UIButton!
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var messageButton: UIButton!
  var tweet: Tweet!
  var id: Int = 0
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        screennameLabel.text = tweet!.name as! String
      /*if let rank = self.postData?.rank {
        self.rankLabel.text = String(describing: rank)
      }*/
      if let username = self.usernameLabel?.text {
        self.usernameLabel!.text = "@" + String(describing: tweet.screenname!)
      }
        textLabel.text = tweet!.text as! String
      
      if let photoData = NSData(contentsOf: tweet.profileUrl as! URL) {
        photoButton.setImage(UIImage(data: photoData as Data), for: .normal)
      }
      
      let formatter = DateFormatter()
      formatter.dateStyle = .medium
      formatter.timeStyle = .short
      let timestamp = formatter.string(from: tweet.timestamp as! Date)
        // Do any additional setup after loading the view.
      dateLabel.text = String(timestamp)
      id = tweet.tweetId
  }
  
  @IBAction func onLikeButton(_ sender: Any) {
    if tweet.favorited {
      TwitterClient.sharedInstance?.unlike(id: id, success: { (tweet: Tweet) in
        self.likeButton.setImage(UIImage(named: "favor-icon"), for: .normal)
      }, failure: { (error: Error) in
        print(error.localizedDescription)
      })
      tweet.favoritesCount = tweet.favoritesCount - 1
      
    } else {
      TwitterClient.sharedInstance?.like(id: id, success: { (tweet: Tweet) in
        self.likeButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        
      }, failure: { (error: Error) in
        print(error.localizedDescription)
      })
      tweet.favoritesCount += 1    }
  }
  
  @IBAction func onRetweetButton(_ sender: Any) {
    if tweet.retweeted {
      TwitterClient.sharedInstance?.unretweet(id: id, success: { (tweet: Tweet) in
        self.retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
      }, failure: { (error: Error) in
        print(error.localizedDescription)
      })
      tweet.retweetCount -= 1
    } else {
      TwitterClient.sharedInstance?.retweet(id: id, success: { (tweet: Tweet) in
        self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
      }, failure: { (error: Error) in
        print(error.localizedDescription)
      })
      tweet.retweetCount += 1
    }
    
  }

  //more temporary function than viewDidLoad
  override func viewDidAppear(_ animated: Bool) {
    retweetCountLabel.text = String(tweet.retweetCount)
    likeCountLabel.text = String(tweet.favoritesCount)
    if tweet.retweeted {
          retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
    }  else {
      retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
    }
    if tweet.favorited {
      likeButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
    } else {
      likeButton.setImage(UIImage(named: "favor-icon"), for: .normal)
    }
    //retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
    //likeButton.setImage(UIImage(named: "favor-icon"), for: .normal)
    replyButton.setImage(UIImage(named: "reply-icon"), for: .normal)
    messageButton.setImage(UIImage(named: "message-icon"), for: .normal)
    
  }
  
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "profileSegue" {
      let vc = segue.destination as! ProfileViewController
      vc.user = tweet.user
    }
  }

}
