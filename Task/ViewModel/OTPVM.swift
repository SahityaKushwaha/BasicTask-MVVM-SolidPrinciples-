//
//  OTPVM.swift
//  
//
//  Created by sahitya kushwaha on 08/03/23.
//

import Foundation

class OTPVM {
    var requestModel: OtpParamRequest
    var validator: CreatePinValidatorDelegate
    var apiHandler: ApiHandlerDelegate
    var responseModel: OTPResponse?
    
    init( _ requestModel: OtpParamRequest, _ validator: CreatePinValidatorDelegate, _ apiHandler: ApiHandlerDelegate) {
        self.requestModel = requestModel
        self.validator = validator
        self.apiHandler = apiHandler
    }
}

extension OTPVM {
    func validateForm() -> String {
        if let msg = validator.validateOtp(otp: requestModel.otp ?? "" ) {
            return msg
        }
        return ""
    }
}

extension OTPVM {
    func otpRequest(_ completionHandler: CallBack?) {
        self.requestModel.url = BASE_URL + VERIFY_OTP
        
        let number = (requestModel.country_code ?? "") + (requestModel.mobile ?? "")
        self.requestModel.param = [NUMBER: number,
                                   OTP: requestModel.otp ?? ""]
        
        apiHandler.request(request: requestModel) { (model) in
            if let data = (model as! ResponseData).data {
                do {
                    let resp = String.init(data: data, encoding: .utf8)
                    logInfo("OTP Response :: \(resp)")
                    let jsonDecoder = JSONDecoder()
                    self.responseModel = try jsonDecoder.decode(OTPResponse.self, from: data)
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
