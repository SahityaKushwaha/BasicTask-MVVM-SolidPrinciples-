
/**
 Class Name        :          Helper.Swift
 Created On        :           08/03/23.
 Developed By        :       Sahitya Kushwaha
 
 Description: This class is about manage the generic function.   */


import Foundation

public class Helper {
    /**
     Generate Boundry
     */
    class func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    /** Replace string function */
    class func replaceString( _ content: String, oldValue:String, newValue: String) ->String
    {
        let newString = content.replacingOccurrences(of: oldValue, with: newValue, options: NSString.CompareOptions.literal, range: nil)
        return newString
    }
    
    /** To get a unique id */
    class func getUniqueId() ->String
    {
        let uniqueId = UUID().uuidString
        return replaceString(uniqueId,oldValue: "-",newValue: "")
    }
    
    class func getTimeZone() -> String{
        return String (TimeZone.current.identifier)
    }
    
    /**
        @Param: mobileNo (This mobile no will be validate)
        This function is about to validate the mobile number, on the basis of some pre-define criteria.
     */
    
    class func isInvalidMobileNo(_ mobileNo: String) -> Bool {
        let invalidMobile: [String] = [
            "0000000", "00000000", "000000000", "00000000000", "000000000000", "0000000000000", "00000000000000", "000000000000000", "0000000000000000","123456","0000001","0000002","0000003","0000004","0000005","0000006","0000007","0000008","0000009","00000010"]
        
        
        let invalidNo = invalidMobile.filter({$0 == mobileNo})
        if invalidNo.count>0 {
            return true
        }
        return false
    }
}
