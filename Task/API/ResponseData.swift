//
//  File.swift
//
//
//  Created by sahitya kushwaha on 08/03/23.
//

import Foundation

/**
 This is the  common structure (ResponseData) structure for handing the response of server.
 */

struct ResponseData{
    let data: Data?
    let code: Int?
    var error: Error?
    
    /**
     There is three @param (data, code & error) is injected here.
     */
    
    init(data: Data?, code: Int, error: Error?) {
        self.data = data
        self.code = code
        self.error = error
    }
}
