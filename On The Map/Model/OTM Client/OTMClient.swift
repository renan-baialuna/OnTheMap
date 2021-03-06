//
//  OTMClient.swift
//  On The Map
//
//  Created by Renan Baialuna on 04/04/21.
//

import Foundation

class OTMClient {
    
    struct Auth {
        static var registered: Bool = false
        static var key: String = ""
        static var id: String = ""
        static var hasLocation: Bool = false
    }
    
    struct User {
        static var firstName: String = ""
        static var lastName: String = ""
    }
    
    enum Endpoints {
        case getStudentsLocation
        case postSession
        case getUserLocation(String)
        case getUserInformation(String)
        case postLocation
        case putLocation(String)
        
        var stringValue: String {
            switch self {
            case .getStudentsLocation:
                return "https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt&limit=100"
            case .postSession:
                return "https://onthemap-api.udacity.com/v1/session"
            case .getUserLocation(let id):
                return "https://onthemap-api.udacity.com/v1/StudentLocation?uniqueKey=\(id)"
            case .getUserInformation(let id):
                return "https://onthemap-api.udacity.com/v1/users/\(id)"
            case .postLocation:
                return "https://onthemap-api.udacity.com/v1/StudentLocation"
            case .putLocation(let id):
                return "https://onthemap-api.udacity.com/v1/StudentLocation/\(id)"
            }
        }
        var baseValue: String {
            return "https://onthemap-api.udacity.com/v1/"
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    // MARK: - Base Calls
    
    @discardableResult class func taskForGetRequest<ResponseType: Decodable>(url: URL, addAccept: Bool = false, responseType: ResponseType.Type, completion: @escaping(ResponseType?, Error?) -> Void) -> URLSessionTask {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                var responseObject: ResponseType
                if addAccept {
                    let range = 5..<data.count
                    let newData = data.subdata(in: range)
                    responseObject = try! decoder.decode(ResponseType.self, from: newData)
                } else {
                    responseObject = try decoder.decode(ResponseType.self, from: data)
                }
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
         return task
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, addAccept: Bool = false, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask {
        var statusCode = 0
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        if addAccept {
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response: URLResponse!, error) in
            if let httpResponse = response as? HTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            if statusCode == 200 {
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    var responseObject: ResponseType
                    if addAccept {
                        let range = 5..<data.count
                        let newData = data.subdata(in: range)
                        responseObject = try decoder.decode(ResponseType.self, from: newData)
                    } else {
                        responseObject = try decoder.decode(ResponseType.self, from: data)
                    }
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                } catch {
                    
                }
            } else {
                completion(nil, error)
            }
            
        }
        task.resume()
        return task
    }
    
    class func taskForPUTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask {
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                var responseObject: ResponseType
                responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                
                
            }
          }
        task.resume()
        return task
    }
    
    class func logoutUser() {
        var request = URLRequest(url: Endpoints.postSession.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        let body = LogoutRequest(sessionId: Auth.id)
        request.httpBody = try! JSONEncoder().encode(body)
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
              return
            }
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range)
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(SessionLogoutData.self, from: newData!)
                
            } catch  {
                print("error")
            }
            Auth.id = ""
            Auth.key = ""
            Auth.registered = false
            
        }
        task.resume()
    }
    
    // MARK: - Calls Implementations
    
    class func loginUser(user: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        
        let body = UserLoginInfo(udacity: UserLoginData(username: user, password: password))
        taskForPOSTRequest(url: Endpoints.postSession.url, addAccept: true, responseType: UserInfo.self, body: body) { (response, error) in
            if let response = response {
                OTMClient.getUserInformation(id: response.account.key)
                Auth.id = response.session.id
                Auth.key = response.account.key
                Auth.registered = response.account.registered
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func getUserLocation() {
        taskForGetRequest(url: Endpoints.getUserLocation(Auth.key).url, responseType: UserLocationInfoResponse.self) { (response, error) in
            if error == nil {
                Auth.hasLocation = response?.results != nil
            } else {
//
            }
        }
        
    }
    
    class func getUserInformation(id: String) {
        taskForGetRequest(url: Endpoints.getUserInformation(id).url, addAccept: true, responseType: UserInformationComplete.self) { (response, error) in
            if error == nil {
                User.firstName = response?.firstName ?? ""
                User.lastName = response?.lastName ?? ""
            } else {
//
            }
        }
    }
    
    class func getStudentsLocations(completion: @escaping ([StudentLocation], Error?) -> Void) {
        taskForGetRequest(url: Endpoints.getStudentsLocation.url, responseType: StudentsResults.self) { (response, error) in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
}
