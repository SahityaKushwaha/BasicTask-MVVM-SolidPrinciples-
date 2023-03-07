//
//  NotesVM.swift
//  Task
//
//  Created by sahitya kushwaha on 08/03/23.
//

import Foundation

class NotesVM {
    var apiHandler: ApiHandlerDelegate
    var responseModel: NotesResponse?
    
    init( _ apiHandler: ApiHandlerDelegate) {
        self.apiHandler = apiHandler
    }
}

extension NotesVM {
    func getNotesRequest(_ completionHandler: CallBack?) {
        let token = (UserDefault.shared.getKeyValue(AUTH) as? String)!
        apiHandler.getRequest(url: BASE_URL + PROFILE_LIST, token: token) { (model) in
            if let data = model as? Data {
                do {
                    let msg = String.init(data: data, encoding: .utf8)
                    debugPrint("NotesResponse = \(msg)")
                    let jsonDecoder = JSONDecoder()
                    self.responseModel = try jsonDecoder.decode(NotesResponse.self, from: data)
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
