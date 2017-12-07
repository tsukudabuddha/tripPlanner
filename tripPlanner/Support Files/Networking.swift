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
//    let baseUrl = "https://travel-pro-tsukudabuddha.herokuapp.com/"
    let baseUrl = "http://127.0.0.1:5000/"

    func getTrips(resource: Resource, completion: @escaping ([Trip]) -> Void) {
        let fullPath = baseUrl + resource.path()
        let url = URL(string: fullPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let username = "tsukudabuddha"
        let password = "password"
        let auth_header = BasicAuth.generateBasicAuthHeader(username: username, password: password)
        request.setValue("Basic \(auth_header)", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { (data, resp, err) in
            if let data = data {
                
                let tripContainer = try? JSONDecoder().decode(TripContainer.self, from: data)
                
                if let trips = tripContainer?.trips {
                    completion(trips)
                } else {
                    print("Post Response: \(String(describing: resp))")
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
        var jsonBody = Data()
        do {
            jsonBody = try JSONEncoder().encode(newUser)
        } catch{}
        request.httpBody = jsonBody
        
        session.dataTask(with: request) { (data, resp, err) in
            if let response = resp {
                completion(response)
            } else {
                // TODO: alert the user that the request did not go through
            }
            }.resume()
    }
    
}

