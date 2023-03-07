
import Foundation
import Alamofire

/**
 Response code
 */

enum ResponseStatus :Int, Codable {
    case SUCCESS = 200
    case VALIDATION = 422
    case UNAUTHORIZED = 401
    case NOT_FOUND = 404
    case SERVER_ERROR = 500
    case METHOD_NOT_FOUND = 405
}

typealias CallBack = ((_ obj:Any)->())

#if DEBUG
let baseURL = "http://52.54.1.108/dev/icash/api/"
let development = true
let showLog = true

#else
let baseURL = "http://52.54.1.108/dev/icash/api/"
let development = false
let showLog = false

#endif


/**
 This is protocol 'WebServiceProtocol'  where two required method is declared.
 */
protocol ParamRequest {
    var url: String? {get set}
    var token: String? {get set}
    var method: String? {get set}
    var interval: TimeInterval? {get set}
    var param: [String:Any]? {get set}
}

/**
 This is protocol 'ApiHandlerDelegate'  where two required method is declared.
 */

protocol ApiHandlerDelegate {
    
    /**
     This method is about to post the request  on server.
     */
    mutating func searchRequest(request: ParamRequest, callBack closure:CallBack?)
    
    /**
     This method is about to post the request  on server.
     */
    mutating func request(request: ParamRequest, callBack closure:CallBack?)
    
    /**
     This method is about to GET the request  on server.
     */
    func getRequest(url: String, token: String, callBack closure:CallBack?)
    
    /**
     This method is about to Upload Images on server.
     */
    func uploadImage(request: ParamRequest, image: UIImage?, imageName: String, callBack closure: CallBack?)
    
    func uploadPdf(request: ParamRequest, documentName: String, data: Data?, callBack closure: CallBack?)
}

/**
 This Webservice Structure is confirming the ApiHandlerDelegate
 */
struct ApiHandler: ApiHandlerDelegate {
    
    var dataTask: DataRequest?
    
    /**
     Implementation of  ' getRequest()'
     */
    func getRequest(url: String, token:String = "", callBack closure:CallBack?) {
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        /** This token is required in few API Only, so we are checking here & adding token. */
        if(!token.isEmpty) {
            headers[AUTH] = "Bearer \(token)"
        }
        
        let request = AF.request(url, headers: headers)
        request.responseJSON { (model) in
            guard let data = model.data else {
                return
            }
            closure?(data)
        }
    }
   
    /** This method is about to post the request API on server. */
    mutating func request(request: ParamRequest, callBack closure:CallBack?) {
        
        var headers: HTTPHeaders = [ "Accept": "application/json" ]
        
        /** This token is required in few API Only, so we are checking here & adding token. */
        if (!(request.token?.isEmpty ?? false)) {
            headers[AUTH] = "Bearer \(request.token ?? "")"
        }
         
        /** Requesting on service using Alamore fore API */
        dataTask = AF.request(request.url ?? "", method: .post,  parameters: request.param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                
                // Request Success Case
                case .success( _):
                    let model = ResponseData(data: response.data, code: 200,error: nil)
                    closure?(model)
                    
                // Request Failure Case
                case .failure(let error):
                    let model = ResponseData(data: nil, code: 0,error: error)
                    closure?(model)
                    break
                }
            }
    }
     
    /** This method is about to post the request API on server. */
    mutating func searchRequest(request: ParamRequest, callBack closure:CallBack?) {
        
        var headers: HTTPHeaders = [ "Accept": "application/json" ]
        
        /** This token is required in few API Only, so we are checking here & adding token. */
        if (!(request.token?.isEmpty ?? false)) {
            headers[AUTH] = "Bearer \(request.token ?? "")"
        }
        
        if let task = dataTask {
            task.cancel()
        }
        
        /** Requesting on service using Alamore fore API */
        dataTask = AF.request(request.url ?? "", method: .post,  parameters: request.param, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                
                // Request Success Case
                case .success( _):
                    let model = ResponseData(data: response.data, code: 200,error: nil)
                    closure?(model)
                    
                // Request Failure Case
                case .failure(let error):
                    let model = ResponseData(data: nil, code: 0,error: error)
                    closure?(model)
                    break
                }
            }
        
    }
    
    /**
     This method is about to Upload Images on server.
     */
    func uploadImage(request: ParamRequest, image: UIImage?, imageName: String, callBack closure:CallBack?)  {
        
        var headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data"
        ]
        
        guard let _url = URL(string: (request.url ?? "")) else {
            return
        }
        
        /** This token is required in few API Only, so we are checking here & adding token. */
        if (!(request.token?.isEmpty ?? false)) {
            headers[AUTH] = "Bearer \(request.token ?? "")"
        }
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 120
       
        
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in request.param ?? ["":""] {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key )
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key )
                }
                
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            if image?.pngData() != nil {
                guard let _data = image?.pngData() else {
                    return
                }
                multiPart.append(_data, withName: imageName, fileName: "\(Helper.getUniqueId()).png", mimeType: "image/png")
            } else {
                logInfo("No image available")
            }
            
        },
        to: _url,
        method: .post,
        headers: headers).responseJSON { (responseValue) in
            let model = ResponseData(data: responseValue.data, code: responseValue.response?.statusCode ?? 0,error: nil)
            closure?(model)
        }
    }
    
    func uploadPdf(request: ParamRequest, documentName: String, data: Data?, callBack closure: CallBack?) {
        var headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data", "Accept": "application/json"
        ]
        
        guard let _url = URL(string: (request.url ?? "")) else {
            return
        }
        
        /** This token is required in few API Only, so we are checking here & adding token. */
        if (!(request.token?.isEmpty ?? false)) {
            headers[AUTH] = "Bearer \(request.token ?? "")"
        }
        
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in request.param ?? ["":""] {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key )
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key )
                }
                
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            guard let _data = data else {
                logInfo("No pdf file is available for upload.")
                return
            }
            multiPart.append(_data, withName: documentName, fileName: "\(Helper.getUniqueId()).pdf", mimeType: "application/pdf")
        },
        to: _url,
        method: .post,
        headers: headers).responseJSON { (responseValue) in
            let model = ResponseData(data: responseValue.data, code: responseValue.response?.statusCode ?? 0,error: nil)
            closure?(model)
        }
    }
    
}
