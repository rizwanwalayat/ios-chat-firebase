//
//  AuthService.swift
//  iChat
//
//  Created by ps on 09/02/2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class AuthService{
    //Singleton (single instance)
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }

    func registerUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased();
      
        let body: [String:Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil{
                completion(true)
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased();
      
        let body: [String:Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
//     Traditional Way of extracting JSON object values

                
                if let json = response.result.value as? Dictionary<String, Any> {
                    guard let email = json["user"] as? String else {
                        completion(false)
                        return
                    }
                    guard let token = json["token"] as? String else {
                        completion(false)
                        return
                    }
                        
                    self.userEmail = email
                    self.authToken = token
                    self.isLoggedIn = true
                    completion(true)
                }
                
//                guard let data = response.data else {return}
//                print("data", data)
//                let json = JSON(data)
//                print("json",json)
//
//                self.userEmail = json["user"].stringValue
//                self.authToken = json["token"].stringValue
//                self.isLoggedIn = true
//
//                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
      
    }
    
    func createUser(name: String, email:String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
            
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                print("response", response)
                //      ObjectMapper
                if let data = Mapper<UserDataService>().map(JSON: response.result.value as! [String : Any]) {
                    print(data)
                    UserDataService.instance = data
                    print(UserDataService.instance)
                }
               completion(true)
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler){
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in

            if response.result.error == nil {
                
                if let data = Mapper<UserDataService>().map(JSON: response.result.value as! [String : Any]) {
                    UserDataService.instance = data
                }
               completion(true)
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
