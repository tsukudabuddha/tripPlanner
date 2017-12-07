//
//  Trip.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 11/12/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import Foundation

struct Trip {
    let destinationCity: String
    let destinationCountry: String
    let landmarks: [String]
    let pictureId: String
    
    init(destinationCountry: String, destinationCity: String, landmarks: [String], pictureId: String) {
        self.destinationCountry = destinationCountry
        self.destinationCity = destinationCity
        self.landmarks = landmarks
        self.pictureId = pictureId
    }
}

struct TripContainer: Decodable {
    let trips: [Trip]
}

extension Trip: Decodable {

    enum Keys: String, CodingKey {
        case destinationCity = "destination_city"
        case destinationCountry = "destination_country"
        case landmarks
        case pictureId
    }
    
    init(from decoder: Decoder) throws {
        // Define Keyed Container
        let container = try decoder.container(keyedBy: Keys.self)
        let destinationCity = try container.decodeIfPresent(String.self, forKey: .destinationCity) ?? ""
        let destinationCountry = try container.decodeIfPresent(String.self, forKey: .destinationCountry) ?? "None"
        let landmarks = try container.decodeIfPresent([String].self, forKey: .landmarks) ?? ["No landmarks"]
        let pictureId = try container.decodeIfPresent(String.self, forKey: .pictureId) ?? ""
        
        self.init(destinationCountry: destinationCountry, destinationCity: destinationCity, landmarks: landmarks, pictureId: pictureId)
    }
}
