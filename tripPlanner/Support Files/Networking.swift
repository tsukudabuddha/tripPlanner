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
 2. BaseUrl -> https://api.producthunt.com/v1/
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
    case posts
    case comments(id: String)
    
    func httpMethod() -> HTTPMethod {
        switch self {
        case .posts, .comments:
            return .get
        }
    }
    
    func httpHeader() -> [String: String] {
        switch self {
        case .posts, .comments:
            return ["Authorization" : "Bearer 77f734273eb7e4b409a3e61aa1827fad91d1e3504e00ec8dac285262ed44f19b",
                    "Accept": "application/json",
                    "Content-Type": "application/json",
                    "Host": "api.producthunt.com"]
        }
    }
    
    func path() -> String {
        switch self {
        case .posts:
            return "/me/feed"
        case .comments(let id):
            return "/posts/\(id)/comments"
        }
    }
}

class Networking {
    let session = URLSession.shared
    let baseUrl = "https://api.producthunt.com/v1"
    
    func getPosts(resource: Resource, completion: @escaping ([Post]) -> Void) {
        let fullPath = baseUrl + resource.path()
        let url = URL(string: fullPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = resource.httpHeader()
        
        session.dataTask(with: request) { (data, resp, err) in
            if let data = data {
                
                let postContainer = try? JSONDecoder().decode(PostContainer.self, from: data)
                
                if let posts = postContainer?.posts {
                    completion(posts)
                } else {
                    print("Post Response: \(String(describing: resp))")
                }
                
            }
            }.resume()
        
    }
    
    func getComments(resource: Resource, completion: @escaping ([Comment]) -> Void) {
        let fullPath = baseUrl + resource.path()
        let url = URL(string: fullPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = resource.httpHeader()
        
        session.dataTask(with: request) { (data, resp, err) in
            if let data = data {
                
                let commentContainer = try? JSONDecoder().decode(CommentContainer.self, from: data)
                if let comments = commentContainer?.comments {
                    completion(comments)
                } else {
                    print("Comment Response: \(String(describing: resp))")
                }
                
            }
            }.resume()
        
    }
}

