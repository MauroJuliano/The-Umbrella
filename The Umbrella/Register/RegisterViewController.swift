//
//  registerViewController.swift
//  The Umbrella
//
//  Created by Lestad on 2021-01-02.
//  Copyright © 2021 Lestad. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    @IBOutlet var buttonView: UIView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    
    let ref: DatabaseReference = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonView.roundCorners(.topLeft, radius: 60)
        // Do any additional setup after loading the view.
    }
    func registerUser(){
        if emailTextField != nil || emailTextField.text != "" {
            let password = passwordTextField.text
            let confirm = confirmPassword.text
            if password == confirm {
                let email = emailTextField.text
                Auth.auth().createUser(withEmail: email!, password: password!, completion: { autoresult, error in
                    if error != nil {
                        
                    }else{
                        self.saveData(email: email!, password: password!, name: self.nameTextField.text!)
                    }
                })
            }
        }
    }
    func saveData(email: String, password: String, name: String){
        let dict: [String: Any] = [
            "name": name,
            "email": email,
            "userID": uid
        ]
        ref.child("users").updateChildValues(dict)
    }
    @IBAction func registerButton(_ sender: Any) {
        registerUser()
    }
    
}
