/**
 Class Name        :          Alert.Swift
 Created On        :           08/03/23..
 Developed By        :         Sahitya Kushwaha
Description: This Alert View controller will have some common alert call.   */

import UIKit
 
public class Alert {
    public static let shared: Alert = {
        let instance = Alert()
        return instance
    }()
    
    private init() {}
}

public extension Alert {
    /**
     Param: @alertTitle: Title of the alert
     Param: @msgTxt: Message descripton of the alert
     Param: @btnName: Button name which is added on the UIAlert.
     Param: @handler: Its a handler to take action agains button click event.
     */
    
    func toastWithOneBtn(_ alertTitle: String, _ msgTxt: String, btnName: String, _ handler: ((_ obj:Any)->())?) {
        let alert = UIAlertController(title: alertTitle
                                      , message: msgTxt, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btnName, style: UIAlertAction.Style.default, handler: {[weak self] (_) in
            guard let self = self else {
                return
            }
            handler?(btnName)
        }))
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?
            .rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    /**
     Param: @alertTitle: Title of the alert
     Param: @msgTxt: Message descripton of the alert
     Param: @firstBtnName: First button name which is added on the UIAlert.
     Param: @secondBtnName: Second button name which is added on the UIAlert.
     Param: @handler: Its a handler to take action agains button click event.
     */
    
    func toastWithTwoBtn(_ alertTitle: String, _ msgTxt: String, firstBtnName: String, secondBtnName: String, _ handler: ((_ obj:Any)->())?) {
        let alert = UIAlertController(title: alertTitle, message: msgTxt, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: firstBtnName, style: UIAlertAction.Style.default, handler: {[weak self] (_) in
            guard let self = self else {
                return
            }
            handler?(firstBtnName)
        }))
        
        alert.addAction(UIAlertAction(title: secondBtnName, style: UIAlertAction.Style.default, handler: {[weak self] (_) in
            guard let self = self else {
                return
            }
            handler?(secondBtnName)
        }))
        
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?
            .rootViewController?.present(alert, animated: true, completion: nil)
    }
}


