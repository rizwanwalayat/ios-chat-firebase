//
//  AvatarCell.swift
//  iChat
//
//  Created by ps on 12/02/2021.
//

import UIKit

enum AvatarType {
    case dark
    case light
}
class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellView()
    }
    
    
    func setupCellView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
//        self.clipsToBounds = true
    }
    
    func configureCellBrightness(index: Int, type: AvatarType){
        if type == AvatarType.dark {
            avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    
    }
}
