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
    
}
