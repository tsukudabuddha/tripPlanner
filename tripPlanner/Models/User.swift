//
//  User.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 12/4/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import Foundation

class User {
    let name: String
    let username: String
    let password: String
    let homeLocation: String
    
    init(username: String, name: String, homeLocation: String, password: String) {
        self.username = username
        self.password = password
        self.name = name
        self.homeLocation = homeLocation
    }
}

extension User: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case password
        case homeLocation = "home_location"
    }
    
    enum HomeLocationKeys: String, CodingKey {
        case city
        case country
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.username, forKey: .username)
        try container.encodeIfPresent(self.password, forKey: .password)
        try container.encodeIfPresent(self.homeLocation, forKey: .homeLocation)
        
    }

}
