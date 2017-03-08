//
//  ComposeViewController.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 3/7/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {


  @IBOutlet weak var countDownLabel: UILabel!
  @IBOutlet var textView: UITextView!
  @IBOutlet weak var tweetButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.countDownLabel.text =
        "140"
      self.textView.delegate = self

        // Do any additional setup after loading the view.
    }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let newLen = textView.text.characters.count - range.length
 
    if (newLen <= 140){
      self.countDownLabel.text = "\(139 - newLen)"
      self.countDownLabel.reloadInputViews()
      return true
    } else {
      return false
    }
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
