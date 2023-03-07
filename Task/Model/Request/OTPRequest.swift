//
//  OTPRequest.swift
//  
//
//  Created by sahitya kushwaha on 08/03/23.
//

import Foundation

protocol OtpParamRequest: ParamRequest {
    var mobile: String? { get set }
    var country_code: String? { get set }
    var otp: String? { get set }
}

struct OtpRequest: OtpParamRequest {
    var url: String?
    var token: String?
    var method: String?
    var interval: TimeInterval?
    var param: [String: Any]?
    
    var mobile: String?
    var country_code: String?
    var otp: String?
}

