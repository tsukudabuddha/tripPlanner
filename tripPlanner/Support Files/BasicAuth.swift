//
//  BasicAuth.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 11/29/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import Foundation

// Thanks to Nate Cook: http://stackoverflow.com/questions/24379601/how-to-make-an-http-request-basic-auth-in-swift

struct BasicAuth {
    static func generateBasicAuthHeader(username: String, password: String) -> String {
        let loginString = String(format: "%@:%@", username, password)
        let loginData: Data = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString(options: .init(rawValue: 0))
        let authHeaderString = "Basic \(base64LoginString)"
        
        return authHeaderString
    }
}
