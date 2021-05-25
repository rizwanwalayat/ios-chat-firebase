//
//  SocketService.swift
//  iChat
//
//  Created by ps on 23/02/2021.
//

import UIKit
import SocketIO
import ObjectMapper

class SocketService: NSObject {

    static let instance = SocketService()
    
    let manager: SocketManager
    let socket: SocketIOClient
    
    override init(){
        self.manager = SocketManager(socketURL: URL(string: BASE_URL)!)
        self.socket = manager.defaultSocket
        super.init()
    }
    
    func establishConnection(){
        socket.connect()
        print("socket ", socket.status)
    }
    
    func closeConnection(){
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        print("newChannelSending")
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            print("newChannelCreated")
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}

            let newChannel = Channel(id: channelId, channelTitle: channelName, channelDescription: channelDesc)
            
            MessageService.instance.channels.append(newChannel)
            completion(true)
            
        }
    }
    
    func socketConnected(completion: @escaping CompletionHandler){
        socket.on(clientEvent: .connect) { (data, ack) in
            print("socket Connected", data)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, user.id, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
        
    }
    
    func getChatMessage(completion: @escaping CompletionHandler){
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timestamp = dataArray[7] as? String else {return}
        
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                let newMessage = Message(id: id, msgBody: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timestamp: timestamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
