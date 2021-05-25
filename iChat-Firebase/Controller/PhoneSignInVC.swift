//
//  PhoneSignInVC.swift
//  iChat
//
//  Created by ps on 18/03/2021.
//

import UIKit
import FirebaseUI

class PhoneSignInVC: UIViewController, FUIAuthDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authUI = FUIAuth.defaultAuthUI()!
        authUI.delegate = self
        
        let providers : [FUIAuthProvider] = [FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()!)]
        authUI.providers = providers
     
        let authViewController = authUI.authViewController()
        
        let phoneProvider = FUIAuth.defaultAuthUI()?.providers.first as! FUIPhoneAuth
        phoneProvider.signIn(withPresenting: authViewController, phoneNumber: nil)
    }



}
