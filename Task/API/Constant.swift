//
//  Constant.swift
// 
//
// Created by sahitya kushwaha on 08/03/23.
//

import Foundation
import UIKit

let BASE_URL = "https://app.aisle.co/V1"
var isInternetAvailale = false

/** Message */
let OK = "Ok"
let NO = "No"
let CANCEL = "Cancel"


let appDel = UIApplication.shared.delegate as! AppDelegate

let SERVER_ERROR = "Server not responding, Please retry"
let SOMETHING_WENT_WRONG = "Something went wrong."
let UNABLE_TO_PARSE = "Issue in Response Parsing"
let SUCCESSFULLY_PARSE = "done"
let INTERNET_CONNECTION_ERROR = "You have no internet connection. Please enable Wi-fi or Mobile Data and try again"
