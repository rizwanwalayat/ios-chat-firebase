//
//  UserDataService.swift
//  iChat
//
//  Created by ps on 10/02/2021.
//

import Foundation
import ObjectMapper

class UserDataService:Mappable{
    
    static var instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    required init?(map: Map) {}
    
    init(){}

    func mapping(map: Map) {
        id <- map["_id"]
        avatarColor <- map["avatarColor"]
        avatarName <- map["avatarName"]
        email <- map["email"]
        name <- map["name"]
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    func getAvatarColor() -> UIColor{
        return returnUIColor(components: avatarColor)
    }
    
    func returnUIColor(components: String?) -> UIColor {
        if var colors = components, components != "" {
            colors.removeFirst()
            colors.removeLast()
            let colorsArray = colors.components(separatedBy: ", ")
            
            let r = CGFloat(Double(colorsArray[0])!)
            let g = CGFloat(Double(colorsArray[1])!)
            let b = CGFloat(Double(colorsArray[2])!)
            let a = CGFloat(Double(colorsArray[3])!)
    
            let newUIColor = UIColor(red: r, green: g, blue: b, alpha: a)
            return newUIColor
        }
        else {
                return UIColor.lightGray
        }
        
    }
    
    func logoutUser(){
        id = ""
        avatarName = ""
        avatarColor = ""
        name = ""
        email = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearAllData()
    }
    
}
