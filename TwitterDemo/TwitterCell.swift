//
//  TwitterCell.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 2/27/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

class TwitterCell: UITableViewCell {
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    let day = Int(24 * 3600)
    let minute = Int(60)
    let hour = Int(3600)
    var rtCount: Int = 0
    var rtCountString: String = ""
    var didRt = false
    var likeCount: Int = 0
    var likeCountString: String = ""
    var didLike = false
    var timeDiff: Int = 0
    var timeString: String = ""

    @IBAction func onRetweet(_ sender: Any) {
        if didRt {
            rtCount -= 1
        }
        else {
            rtCount += 1
        }
        didRt = !didRt
        setButtonCount()
    }
    @IBAction func onLike(_ sender: Any) {
        if didLike{
            likeCount = likeCount - 1
        }
        else {
            likeCount = likeCount + 1
        }
        didLike = !didLike
        setButtonCount()
    }
    
    
    
       var tweet: Tweet! {
        didSet {
            screennameLabel.text = tweet.name as? String
            usernameLabel.text = "@" + (tweet.screenname as? String)!
            timestampLabel.text = String(describing: tweet.timestamp)
            tweetLabel.text = tweet.text as? String
            timeDiff = Int(Date().timeIntervalSince(tweet.timestamp as! Date))
            if timeDiff < minute {
                timeString = String("less than a minute ago")
            }
            else if timeDiff < hour {
                timeDiff = timeDiff/minute
                timeString = String(timeDiff) + "m"
            }
            else if timeDiff < day {
                timeDiff = timeDiff/hour
                timeString = String(timeDiff) + "h"
            }
            else {
                timeDiff = timeDiff/day
                timeString = String(timeDiff) + " days ago"
            }
            
            timestampLabel.text = timeString
            
            let replyImage = UIImage(named: "reply-icon")
            replyButton.setImage(replyImage, for: .normal)
            
            if tweet.retweeted == false {
                let retweetImage = UIImage(named: "retweet-icon")
                retweetButton.setImage(retweetImage, for: .normal)
                didRt = false
            }
            else {
                let retweetImage = UIImage(named: "retweet-icon-green")
                retweetButton.setImage(retweetImage, for: .normal)
                didRt = true
            }
            
            if tweet.favorited == false {
                let likeImage = UIImage(named: "favor-icon")
                likeButton.setImage(likeImage, for: .normal)
                didLike = false
            }
            else {
                let likeImage = UIImage(named: "favor-icon-red")
                likeButton.setImage(likeImage, for: .normal)
                didLike = true
            }
            
            likeCount = tweet.favoritesCount
            rtCount = tweet.retweetCount
            setButtonCount()
            
            if let photoData = NSData(contentsOf: tweet.profileUrl as! URL) {
                profileButton.setImage(UIImage(data: photoData as Data), for: .normal)
            }

        }
    }
    
    
    
    func setButtonCount() {
        if likeCount < 1000 {
            likeCountString = String(likeCount)
        }
        else {
            likeCountString = String((likeCount/1000)) + "K"
        }
        
        likeButton.setTitle(likeCountString, for: .normal)
        
        if rtCount < 1000 {
            rtCountString = String(rtCount)
        }
        else {
            rtCountString = String((rtCount/1000)) + "K"
        }
        retweetButton.setTitle(rtCountString, for: .normal)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
