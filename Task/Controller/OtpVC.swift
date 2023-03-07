//
//  OtpVC.swift
//  Task
//
//   Created by sahitya kushwaha on 08/03/23.
//

import UIKit

class OtpVC: BaseVC {
    
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblEnterOtp: UILabel!
    @IBOutlet weak var txtFldOTP: UITextField!
    @IBOutlet weak var lblOTPTimer: UILabel!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var continueBtnAction: UIButton!
    
    var viewModel: OTPVM?
    var mobile: String?
    var country_code: String?
    
    var countdownTimer: Timer!
    var totalTime = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    /**
     This getInstance() function is about to get the VC Screen reference from Storyboard. */
    static func getInstance()->OtpVC? {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: "OtpVC") as? OtpVC
    }
    deinit {
        
        debugPrint("\(self) :: No Memory Leak")
    }
    
    func setupVC() {
        txtFldOTP.delegate = self
        lblEnterOtp.text = "Enter The \nOTP"
        lblOTPTimer.text = ""
        lblMobile.text = (country_code ?? "") + " " + (mobile ?? "")
        continueBtnAction.layer.cornerRadius = 20
        resendBtn.isHidden = true
        if viewModel == nil {
            viewModel = OTPVM(OtpRequest(), CreatePinValidator(), ApiHandler())
        }
        sendOTPAPICall()
    }
}

extension OtpVC {
    
    @IBAction func editBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {
       initiateRequest()
    }
    
    @IBAction func resendOTPBtn(_ sender: Any) {
        sendOTPAPICall()
        lblOTPTimer.text = ""
        totalTime = 31
    }
}

extension OtpVC {
    @objc func updateTimerLabel() {
        totalTime -= 1
        lblOTPTimer.text = "\(timeFormatted(totalTime))"
        if totalTime == 0 {
            lblOTPTimer.text = ""
            countdownTimer.invalidate()
            resendBtn.isHidden = false
        }
    }
    
    func countDownTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.lblOTPTimer.isHidden = false
            self.resendBtn.isHidden = false
            if self.lblOTPTimer.isHidden == false {
                self.startTimer()
            } else {
                self.countdownTimer.invalidate()
                self.resendBtn.isHidden = true
                self.lblOTPTimer.isHidden = true
            }
        }
    }
    
    func sendOTPCode() {
        resendBtn.isHidden = true
        self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    // Method to start the timer when resend OTP button is clicked.
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    @objc func updateTime() {
        DispatchQueue.main.async() {
            self.lblOTPTimer.text = self.timeFormatted(self.totalTime)
            if self.totalTime != 0 {
                self.totalTime -= 1
            } else {
                print("Invalidated")
                self.endTimer()
                
            }
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension OtpVC {
    func sendOTPAPICall() {
        //api logic
        //if success {
        self.sendOTPCode()
    }
}

extension OtpVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLength
    }
}

extension OtpVC {
    func initiateRequest() {
        viewModel?.requestModel.mobile = mobile
        viewModel?.requestModel.country_code = country_code
        viewModel?.requestModel.otp = txtFldOTP.text
        let errorMsg = self.viewModel?.validateForm()
        if errorMsg?.count == 0 {
        if isInternetAvailale {
            self.showLoader()
            self.viewModel?.otpRequest({ response in
                self.hideLoader()
                if (response as? String) == "done" {
                    if let model = self.viewModel?.responseModel {
                        if model.message == nil  && model.token != nil {
                            if let token = model.token {
                                UserDefault.shared.saveKeyValue(AUTH, value: token)
                            }
                            if let vc = TabBarVC.getInstance() {
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        } else {
                            Alert.shared.toastWithOneBtn(model.title ?? "", model.message ?? "Please Enter Correct OTP", btnName: "Ok") { (_) in
                            }
                        }
                    }
                } else {
                    Alert.shared.toastWithOneBtn("",self.viewModel?.responseModel?.message ?? "", btnName: "Ok") { (_) in
                    }
                }
            }) }
        else {
            Alert.shared.toastWithOneBtn("", INTERNET_CONNECTION_ERROR, btnName: "Ok") { (_) in
            }
        }
        }
        else {
            Alert.shared.toastWithOneBtn("", errorMsg ?? "", btnName: OK) { (_) in
            }
        }
    }
}
