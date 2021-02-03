//
//  MenuVC.swift
//  iChat
//
//  Created by ps on 02/02/2021.
//

import UIKit

class MenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size
            .width - 60
        
    }
    

}
