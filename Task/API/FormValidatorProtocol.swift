//
//  FormValidatorProtocol.swift
//  
//
//  Created by sahitya kushwaha on 08/03/23.
//

import Foundation

struct ValidationError {
    var status: Bool?
    var msg: String?
}

protocol FormValidatorProtocol {
    func validateForm(_ completionHandler: CallBack?)
}
