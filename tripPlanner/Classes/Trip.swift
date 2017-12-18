//
//  Trip.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 11/12/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import Foundation

struct Trip: Equatable {
    
    static func ==(lhs: Trip, rhs: Trip) -> Bool {
        if lhs._id == rhs._id && lhs.landmarks == rhs.landmarks && lhs.destinationCity == rhs.destinationCity && lhs.destinationCountry == rhs.destinationCountry && lhs.travelers == rhs.travelers && lhs.pictureId == rhs.pictureId {
            return true
        } else {
            return false
        }
    }
    
    let _id: String
    let destinationCity: String
    let destinationCountry: String
    let landmarks: [String]
    let pictureId: String
    let travelers: [String]
    
    init(_id: String, destinationCountry: String, destinationCity: String, landmarks: [String], pictureId: String, travelers: [String]) {
        self._id = _id
        self.destinationCountry = destinationCountry
        self.destinationCity = destinationCity
        self.landmarks = landmarks
        self.pictureId = pictureId
        self.travelers = travelers
    }
    
    enum Keys: String, CodingKey {
        case _id
        case destinationCity = "destination_city"
        case destinationCountry = "destination_country"
        case landmarks
        case pictureId
        case travelers
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(self.destinationCity, forKey: .destinationCity)
        try container.encodeIfPresent(self.destinationCountry, forKey: .destinationCountry)
        try container.encodeIfPresent(self.landmarks, forKey: .landmarks)
        try container.encodeIfPresent(self.pictureId, forKey: .pictureId)
        try container.encodeIfPresent(self.travelers, forKey: .travelers)
    }
    
}

extension Trip: Codable {
    
    init(from decoder: Decoder) throws {
        // Define Keyed Container
        let container = try decoder.container(keyedBy: Keys.self)
        
        let id = try container.decodeIfPresent(String.self, forKey: ._id) ?? ""
        let destinationCity = try container.decodeIfPresent(String.self, forKey: .destinationCity) ?? ""
        let destinationCountry = try container.decodeIfPresent(String.self, forKey: .destinationCountry) ?? "None"
        let landmarks = try container.decodeIfPresent([String].self, forKey: .landmarks) ?? ["No landmarks"]
        let pictureId = try container.decodeIfPresent(String.self, forKey: .pictureId) ?? ""
        let travelers = try container.decodeIfPresent([String].self, forKey: .travelers) ?? ["No one"]
        
        self.init(_id: id, destinationCountry: destinationCountry, destinationCity: destinationCity, landmarks: landmarks, pictureId: pictureId, travelers: travelers)
    }
}
