//
//  UserLocationInfoResponse.swift
//  On The Map
//
//  Created by Renan Baialuna on 25/04/21.
//

import Foundation

// MARK: - UserLocationInfoResponse
struct UserLocationInfoResponse: Codable {
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let firstName, lastName: String
    let longitude, latitude: Double
    let mapString, mediaURL: String
    let uniqueKey, objectID, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case firstName, lastName, longitude, latitude, mapString, mediaURL, uniqueKey
        case objectID = "objectId"
        case createdAt, updatedAt
    }
}
