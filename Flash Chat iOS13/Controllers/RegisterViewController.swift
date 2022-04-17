//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        debugPrint("Entering in register pressed,\(emailTextfield.text) \(passwordTextfield.text)")
        print(#function)
        if  let email = emailTextfield.text, let password = passwordTextfield.text {
        Auth.auth().createUser(withEmail: email,
                              password: password) { authResult, error in
            print("Llamada a create user completada")
            if let e = error {
                debugPrint(e)
                print("Se produjo un error")
            } else {
                // Navigate to the chat view Controller
                print("Se hizo el registro)")
                self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                
            }
        }
        }
    }
    
}
