//
//  LoginVM.swift
//  Task
//
//  Created by sahitya kushwaha on 08/03/23.
//

import Foundation

class PhoneNumberVM {
    
    var requestModel: PhoneNumberParamRequest
    var validator: PhoneNumberValidatorDelegate
    var apiHandler: ApiHandlerDelegate
    var responseModel: PhoneNumberResponse?
    
    init( _ requestModel: PhoneNumberParamRequest,  _ validator: PhoneNumberValidatorDelegate, _ apiHandler: ApiHandlerDelegate) {
        self.requestModel = requestModel
        self.validator = validator
        self.apiHandler = apiHandler
    }
}

extension PhoneNumberVM {
    
    func validateForm(_ completionHandler: CallBack?) {
        var validated: Bool = true
        
        if let msg = validator.validateMobileNumber(mobileNo: requestModel.mobile ?? "") {
            validated = false
            completionHandler?(msg)
        }
        
        if requestModel.dialCode?.isEmpty == true {
            validated = false
            completionHandler?("Please Enter DialCode")
        }
        
        if validated == true {
            completionHandler?("")
        }
    }
}

extension PhoneNumberVM {
    func loginRequest(_ completionHandler: CallBack?) {
        self.requestModel.url = BASE_URL + PHONE_NUMBER_LOGIN
        let number = (requestModel.dialCode ?? "") + (requestModel.mobile ?? "")
        
        self.requestModel.param = [NUMBER: number]
        
        print(requestModel.param)
        apiHandler.request(request: requestModel) { (model) in
            if let data = (model as! ResponseData).data {
                do {
                    let resp = String.init(data: data, encoding: .utf8)
                    logInfo("Phone Number Response :: \(resp)")
                    let jsonDecoder = JSONDecoder()
                    self.responseModel = try jsonDecoder.decode(PhoneNumberResponse.self, from: data)
                    completionHandler?(SUCCESSFULLY_PARSE)
                } catch {
                    completionHandler?(UNABLE_TO_PARSE)
                }
            } else {
                completionHandler?(SOMETHING_WENT_WRONG)
            }
        }
    }
}
