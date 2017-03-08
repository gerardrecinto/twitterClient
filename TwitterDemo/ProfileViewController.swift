//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 3/6/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  @IBOutlet weak var coverPhotoImage: UIImageView!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var atSymbolUsernameLabel: UILabel!
  @IBOutlet weak var tweetCountLabel: UILabel!
  @IBOutlet weak var followingCountLabel: UILabel!
  @IBOutlet weak var followingLabel: UILabel!
  @IBOutlet weak var followerCountLabel: UILabel!
  @IBOutlet weak var followerLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  var user: User!
    override func viewDidLoad() {
        super.viewDidLoad()
      if user.coverPhotoUrl != URL(string: "") {
        coverPhotoImage.setImageWith(user.coverPhotoUrl!)
      }
      if user.profileUrl != URL(string: ""){
        profileImage.setImageWith(user.profileUrl!)
      }
      usernameLabel.text = String(describing: user.name!)
      atSymbolUsernameLabel.text = "@" + String(describing: user.screenname!)
      tweetCountLabel.text = String(user.tweetsCount)
      followerCountLabel.text = String(user.followerCount)
      followingCountLabel.text = String(user.followingCount)
      descriptionLabel.text = String(describing: user.tagline!)
        // Do any additional setup after loading the view.
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
  



}
