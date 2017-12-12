//
//  Networking.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 12/01/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//
import Foundation

/*
 Parts of a URL
 1. URLSession
 2. BaseUrl -> https://travel-pro-tsukudabuddha.herokuapp.com/
 3. HTTPMethod
 4. Body?
 5. Headers
 6. Query Parameters
 7. Path
 */

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum Resource {
    case users
    case trips
    
    func path() -> String {
        switch self {
        case .users:
            return "users"
        case .trips:
            return "trips"
        }
    }
}

class Networking {
    let session = URLSession.shared
    let baseUrl = "https://travel-pro-tsukudabuddha.herokuapp.com/"
//    let baseUrl = "http://127.0.0.1:5000/"

    func getTrips(resource: Resource, username: String, password: String, completion: @escaping ([Trip?]) -> Void) {
        let request = generateRequest(resource: resource, method: .get, authorizationRequired: true, username: username, password: password)
//        let fullPath = baseUrl + resource.path()
//        let url = URL(string: fullPath)!
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        let auth_header = BasicAuth.generateBasicAuthHeader(username: username, password: password)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue(auth_header, forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { (data, resp, err) in
            if let data = data {
                
                let trips = try? JSONDecoder().decode([Trip].self, from: data)

                if let trips = trips {
                    completion(trips)
                } else {
                    print("Get trips Response: \(String(describing: resp))")
                    print("trip: \(data.description)")
                }
                
            }
            }.resume()
        
    }
    
    func addUser(resource: Resource, newUser: User, completion: @escaping ((URLResponse) -> Void)) {
        let fullPath = baseUrl + resource.path()
        let url = URL(string: fullPath)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let encodedData = try? JSONEncoder().encode(newUser)
        request.httpBody = encodedData
        
        session.dataTask(with: request) { (data, resp, err) in
            if let response = resp {
                completion(response)
            }
        }.resume()
    }
    
    func generateRequest(resource: Resource, method: HTTPMethod, authorizationRequired: Bool, username: String?, password: String?) -> URLRequest {
        let fullPath = baseUrl + resource.path()
        let url = URL(string: fullPath)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if authorizationRequired {
            let auth_header = BasicAuth.generateBasicAuthHeader(username: username!, password: password!)
            request.setValue(auth_header, forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
}

