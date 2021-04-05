//
//  OTMClient.swift
//  On The Map
//
//  Created by Renan Baialuna on 04/04/21.
//

import Foundation

class OTMClient {
    enum Endpoints {
        case getStudentsLocation
        
        var stringValue: String {
            switch self {
            case .getStudentsLocation:
                return "https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    @discardableResult class func taskForGetRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping(ResponseType?, Error?) -> Void) -> URLSessionTask {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
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
