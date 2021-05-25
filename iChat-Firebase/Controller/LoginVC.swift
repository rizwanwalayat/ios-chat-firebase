//
//  LoginVC.swift
//  iChat
//
//  Created by ps on 03/02/2021.
//

import UIKit

class LoginVC: UIViewController {

    //Outlets
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(gesture)
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
 
    @IBAction func loginPressed(_ sender: Any) {
        loader.isHidden = false
        loader.startAnimating()
        guard let email = usernameTxt.text, usernameTxt.text != "" else {return}
        guard let password = passwordTxt.text, passwordTxt.text != "" else {return}
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if (success) {
                AuthService.instance.findUserByEmail { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
                        self.loader.isHidden = true
                        self.loader.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        //performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
        performSegue(withIdentifier: TO_SIGN_UP, sender: nil)
    }
    
    func setupView(){
        loader.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: bluePlaceholder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: bluePlaceholder])
        
    }
    
}
