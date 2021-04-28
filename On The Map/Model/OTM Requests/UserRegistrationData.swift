//
//  UserRegistrationData.swift
//  On The Map
//
//  Created by Renan Baialuna on 26/04/21.
//

import Foundation


struct UserRegistrationData: Codable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    
    init (id: String, firstName: String, lastName: String, mediaURL: String, location: Location) {
        uniqueKey = id
        self.firstName = firstName
        self.lastName = lastName
        self.mediaURL = mediaURL
        mapString = location.mapString
        latitude = location.latitude
        longitude = location.longitude
    }
}

struct Location {
    let latitude: Double
    let longitude: Double
    let mapString: String
}
