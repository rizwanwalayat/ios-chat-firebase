//
//  CreateAccountVC.swift
//  iChat
//
//  Created by ps on 03/02/2021.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func pickBgColorPressed(_ sender: Any) {
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else {
            return
        }
        guard let pass = passwordTxt.text, passwordTxt.text != "" else {
            return
        }
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("Registered User!")
            }
        }
    }
    

}
