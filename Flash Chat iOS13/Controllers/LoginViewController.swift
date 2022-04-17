//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        debugPrint("loginPressed")
        if  let email = emailTextfield.text, let password = passwordTextfield.text {
            debugPrint("email \(email)")
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
                debugPrint(e)
            } else {
                self.performSegue(withIdentifier: "loginToChat", sender: self)
            }
            
        }
        }
    }
    
}
