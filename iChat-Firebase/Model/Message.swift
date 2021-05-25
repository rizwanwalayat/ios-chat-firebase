//
//  Message.swift
//  iChat
//
//  Created by ps on 15/03/2021.
//

import Foundation
import ObjectMapper

struct Message: Mappable {
   
    public private(set) var id: String = ""
    public private(set) var message: String = ""
    public private(set) var userName: String = ""
    public private(set) var channelId: String = ""
    public private(set) var userAvatar: String = ""
    public private(set) var userAvatarColor: String = ""
    public private(set) var timestamp: String = ""
    
    init?(map: Map) {
    }
    
    init(id: String, msgBody: String, userName: String, channelId: String, userAvatar: String, userAvatarColor: String, timestamp: String){
        self.id = id
        self.message = msgBody
        self.userName = userName
        self.channelId = channelId
        self.userAvatar = userAvatar
        self.userAvatarColor = userAvatarColor
        self.timestamp = timestamp
    }
    
        mutating func mapping(map: Map) {
        id <- map["_id"]
        message <- map["messageBody"]
        userName <- map["userName"]
        channelId <- map["channelId"]
        userAvatar <- map["userAvatar"]
        userAvatarColor <- map["userAvatarColor"]
        timestamp <- map["timestamp"]
    }
    
}
