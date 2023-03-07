//
//  OtpRule.swift
//  
//
//  Created by sahitya kushwaha on 08/03/23.
//

import Foundation

let OTP_LENGTH = 4
let ENTER_OTP = "Please Enter OTP"
let INVALID_OTP = "Please Enter 4 Digit OTP"

let ENTER_PIN = "Please Enter New PIN"
let INVALID_PIN = "Please Enter 4 Digit PIN"

let MATCH_PIN = "New Pin and Confirm Pin Do Not Match"

/**
 This is OTP validation protocol
 */
protocol OtpRule {
    func validateOtp(otp value:String) -> String?
}

/**
 This is the extension of OTP
 */
extension OtpRule {
    func validateOtp(otp value:String) -> String? {
        if value.isEmpty {
            return ENTER_OTP
        }
        
        if value.count != OTP_LENGTH {
            return INVALID_OTP
        }
        if value == "0000" {
            return "Please Enter Valid Pin"
        }
        
        return nil
    }
}

