
import Foundation

let INVALID_MOBILE_NO = "Invalid Mobile Number"
let ENTER_MOBILE_NO = "Enter Mobile Number"
let MOBILE_NO_LENGTH_LIMIT = "Mobile Number Should be 7 to 15 Digits"
let MIN_MOBILE_TEXT_LENGTH = 7
let MAX_MOBILE_TEXT_LENGTH = 15

/**
 This is mobile number validation protocol
 */
protocol MobileNumberRule {
    func validateMobileNumber(mobileNo value: String) -> String?
}

/** This is the extension of MobileNumberRule */
extension MobileNumberRule {
    func validateMobileNumber(mobileNo value: String)->String? {
        
        if value.isEmpty {
            return ENTER_MOBILE_NO
        } else {
            if Helper.isInvalidMobileNo(value) {
                return INVALID_MOBILE_NO
            }
            
            if value.count < MIN_MOBILE_TEXT_LENGTH {
                return MOBILE_NO_LENGTH_LIMIT
            }
            
            if value.count > MAX_MOBILE_TEXT_LENGTH {
                return MOBILE_NO_LENGTH_LIMIT
            }
              
        }
        
//        if value.isEmpty {
//            return ENTER_MOBILE_NO
//        }
        
        
        return nil
        
    }
    
}
