//
//  SignUpVC.swift
//  iChat
//
//  Created by ps on 22/03/2021.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var phoneBtn: RoundedButton!
    @IBOutlet weak var emailBtn: RoundedButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneBtn.tintColor = .white
        emailBtn.tintColor = .white
        // Do any additional setup after loading the view.
    }
    

    @IBAction func phoneBtnPressed(_ sender: Any) {
        let phoneSignInVC = PhoneSignInVC()
        self.present(phoneSignInVC, animated: true, completion: nil)
    }
    
    @IBAction func emailBtnPressed(_ sender: Any) {
    performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true , completion: nil)
    }
    
}
