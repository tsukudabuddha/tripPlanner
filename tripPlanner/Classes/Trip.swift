//
//  Trip.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 11/12/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import Foundation

class Trip {
    let destination: String
    let duration: Int
    let landmarks: [String]
    let pictureId: String
    
    init(destination: String, duration: Int, landmarks: [String], pictureId: String) {
        self.destination = destination
        self.duration = duration
        self.landmarks = landmarks
        self.pictureId = pictureId
    }
}
