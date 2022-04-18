//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit


class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        var charIndex = 0
        titleLabel.text = ""
        loginButton.isHidden = true
        registerButton.isHidden = true
        let titleText = K.appName
        for letter in titleText{
            
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(charIndex), repeats: false) { (timer) in
                self.titleLabel.text?.append( letter)
            }
            charIndex += 1
        }
        Timer.scheduledTimer(withTimeInterval: 0.1 * Double(charIndex), repeats: false) { (timer) in
            self.loginButton.isHidden = false
            self.registerButton.isHidden = false
        }
  
        
    }
    

}
