//
//  Channel.swift
//  iChat
//
//  Created by ps on 19/02/2021.
//

import Foundation
import ObjectMapper

struct Channel: Mappable {
    
    var id: String = ""
    var channelTitle: String = ""
    var channelDescription: String = ""
    
    init?(map: Map) {
    }
    
    init(id:String, channelTitle: String, channelDescription: String) {
        self.id = id
        self.channelTitle = channelTitle
        self.channelDescription = channelDescription
    }
    
    mutating func mapping(map: Map) {
        id <- map["_id"]
        channelTitle <- map["name"]
        channelDescription <- map["description"]

    }
    
    
  
}
