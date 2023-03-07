//
//  Request.swift
//
//
//  Created by sahitya kushwaha on 08/03/23.
//

import Foundation

protocol PhoneNumberParamRequest: ParamRequest {
    var mobile: String? { get set }
    var dialCode: String? { get set }
}

struct PhoneNumberRequest: PhoneNumberParamRequest {
    var mobile: String?
    var dialCode: String?
    var url: String?
    var token: String?
    var method: String?
    var interval: TimeInterval?
    var param: [String : Any]?
}
