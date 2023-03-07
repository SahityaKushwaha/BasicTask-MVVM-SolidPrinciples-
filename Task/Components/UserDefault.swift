
/**
 Class Name        :          UserDefault.Swift
 Created On        :           08/03/23..
 Developed By        :        Sahitya Kushwaha
 
 Description: This class is about to manage the data into Userdefault. */

import Foundation

public protocol UserDefaultProtocol {
    func saveKeyValue(_ key: String, value: Any)
    func getKeyValue(_ key: String) -> Any
    func removeValue(_ key: String)
}
 
public class UserDefault: UserDefaultProtocol {
    
    public static let shared: UserDefault = {
        let instance = UserDefault()
        return instance
    }()
    
    private init() {}
}

public extension UserDefault {
    
    /**
     @Param :
     1. key: This is key name for which we will save data
     2. value: This is the value that we are saving for given key
     */
    
    func saveKeyValue(_ key: String, value: Any)
    {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    /**
     @Param :
     1. key: This is key name for which we will get value from saved data.
    */
    func getKeyValue(_ key: String) -> Any
    {
        let defaults = UserDefaults.standard
        return defaults.value(forKey: key) ?? ""
    }
    
    /**
     @Param :
     1. key: This is key name for which we will remvoe value from saved data.
    */
    
    func removeValue(_ key: String)
    {
        let defaults = UserDefaults.standard
        debugPrint("remove key = \(key)")
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
}
