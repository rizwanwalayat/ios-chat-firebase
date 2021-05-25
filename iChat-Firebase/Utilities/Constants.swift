//
//  Contacts.swift
//  iChat
//
//  Created by ps on 03/02/2021.
//

import Foundation

typealias CompletionHandler = (_ Success:Bool) -> ()

// URL Constants
let BASE_URL = "https://ichat-nodejs.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel/"
//Colors
let bluePlaceholder = #colorLiteral(red: 0.2258920911, green: 0.4750483934, blue: 0.8549019694, alpha: 0.5)

// Notification Constants
let NOTIF_USER_DATA_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("channelSelected")

//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let TO_SIGN_UP = "toSignUp"
let UNWIND_MENU = "unwindToMenu"
let TO_AVATAR_PICKER = "toAvatarPicker"

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
    "Content-type": "application/json; charset=utf-8"
]
let BEARER_HEADER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-type": "application/json; charset=utf-8"
]
