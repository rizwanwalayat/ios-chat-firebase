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
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    // avatar variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.modalPresentationStyle = .fullScreen
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear.avatarName",UserDataService.instance.avatarName)
         if UserDataService.instance.avatarName != "" {
             userImg.image = UIImage(named: UserDataService.instance.avatarName)
             avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
         }
    }
    
    
    @IBAction func pickBgColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        UIView.animate(withDuration: 0.2) {
            self.userImg.backgroundColor = self.bgColor
        }
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_MENU, sender: nil)
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        loader.isHidden = false
        loader.startAnimating()
        
        guard let name = usernameTxt.text, usernameTxt.text != "" else {return}
        guard let email = emailTxt.text, emailTxt.text != "" else {
            return
        }
        guard let pass = passwordTxt.text, passwordTxt.text != "" else {
            return
        }
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("registered")
                AuthService.instance.loginUser(email: email, password: pass) { (success) in
                    if success {
                        print("logged in")
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor) { (success) in
                            if success {
                                self.loader.isHidden = true
                                self.loader.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND_MENU, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
//                                self.performSegue(withIdentifier: "", sender: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func setupView(){
        loader.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: bluePlaceholder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: bluePlaceholder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: bluePlaceholder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
    }

    @objc func handleTap(){
        view.endEditing(true)
    }
}
