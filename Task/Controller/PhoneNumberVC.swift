//
//  PhoneNumberVC.swift
//  Task
//
//  Created by sahitya kushwaha on 08/03/23.
//

import UIKit
import CountryPickerView

class PhoneNumberVC: BaseVC {
    
    @IBOutlet weak var txtFldMobileNumber: UITextField!
    @IBOutlet weak var txtFldCode: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    
    var viewModel: PhoneNumberVM?
    var picker = CountryPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    func setupVC() {
        continueBtn.layer.cornerRadius = 20
        if viewModel == nil {
            viewModel = PhoneNumberVM(PhoneNumberRequest(), PhoneNumberValidator(), ApiHandler())
        }
    }
    
    @IBAction func codeBtnAction(_ sender: Any) {
        picker.delegate = self
        picker.dataSource = self
        picker.showCountriesList(from: self)
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {
        initiateRequest()
    }
}

extension PhoneNumberVC: CountryPickerViewDelegate, CountryPickerViewDataSource {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        logInfo(country.phoneCode)
        txtFldCode.text = country.phoneCode
        txtFldCode.sizeToFit()
    }
}

extension PhoneNumberVC {
    func initiateRequest() {
        viewModel?.requestModel.dialCode = txtFldCode.text
        viewModel?.requestModel.mobile = txtFldMobileNumber.text
        
        viewModel?.validateForm({ (status) in
            if let isValid = status as? String {
                if isValid.count != 0 {
                    Alert.shared.toastWithOneBtn("Error", isValid, btnName: "Ok") { (_) in
                    }
                } else {
                    if isInternetAvailale {
                        self.showLoader()
                        self.viewModel?.loginRequest({ response in
                            self.hideLoader()
                            if (response as? String) == SUCCESSFULLY_PARSE {
                                if let model = self.viewModel?.responseModel {
                                    if model.status == true {
                                        print("otp")
                                        if let vc = OtpVC.getInstance() {
                                            vc.mobile = self.viewModel?.requestModel.mobile
                                            vc.country_code = self.viewModel?.requestModel.dialCode
                                            self.navigationController?.pushViewController(vc, animated: true)
                                        }
                                    } else {
                                        Alert.shared.toastWithOneBtn("Error", SOMETHING_WENT_WRONG, btnName: "Ok") { (_) in
                                        }
                                    }
                                }
                            }
                        })
                    }  else {
                        Alert.shared.toastWithOneBtn("", INTERNET_CONNECTION_ERROR, btnName: "Ok") { (_) in
                        }
                    }
                }
            }
        })
    }
}

