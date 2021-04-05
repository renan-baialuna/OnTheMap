//
//  StudentLocation.swift
//  On The Map
//
//  Created by Renan Baialuna on 04/04/21.
//

import Foundation

struct StudentLocation: Codable {
    let objectId: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
}
