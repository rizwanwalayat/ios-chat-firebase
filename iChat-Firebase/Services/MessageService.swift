//
//  MessageService.swift
//  iChat
//
//  Created by ps on 19/02/2021.
//

import Foundation
import Alamofire
import ObjectMapper

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var channelsLoaded = false
    var selectedChannel: Channel?
    
    func findAllChannels(completion: @escaping CompletionHandler) {
//        print("getAllChannels")
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
//            print("response", response)
            if response.result.error == nil {
                if let data = Mapper<Channel>().mapArray(JSONObject: response.value ) {
                    self.channels = data
                    self.channelsLoaded = true
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil )
                    completion(true)
                }
                else {
                    completion(false)
                    self.channelsLoaded = true
                    debugPrint(response.result.error as Any)
                }
            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func findAllMessagesByChannel(channelId: String, completion: @escaping CompletionHandler){
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            print("URL_GET_MESSAGES",response)
            if response.result.error == nil {
                self.clearMessages()
                if let data = Mapper<Message>().mapArray(JSONObject: response.value){
                    print("data",data)
                    self.messages = data
                }
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
        
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
    func clearAllData(){
        clearChannels()
        clearMessages()
    }
}
