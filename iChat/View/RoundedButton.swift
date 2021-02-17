//
//  RoundedButton.swift
//  iChat
//
//  Created by ps on 10/02/2021.
//

import UIKit

//@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupRadiusView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupRadiusView()
    }
    
    func setupRadiusView() {
        self.layer.cornerRadius = cornerRadius
    }
   
}
