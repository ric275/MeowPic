//
//  LoginViewController.swift
//  MeowPic
//
//  Created by Jack Taylor on 11/10/2016.
//  Copyright © 2016 Jack Taylor. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func GetMeowdTapped(_ sender: AnyObject) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("Sign in attempted")
            if error != nil {
                print("error:\(error)")
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("User creation attempted")
                    if error != nil {
                        print("error:\(error)")
                    } else {
                        print("Created user successfully")
                        
                        FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                        
                        
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                })
                
            } else {
                print("Sign in successful")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        })
    }
}

