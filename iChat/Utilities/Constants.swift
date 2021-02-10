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

//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND_MENU = "unwindToMenu"

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
