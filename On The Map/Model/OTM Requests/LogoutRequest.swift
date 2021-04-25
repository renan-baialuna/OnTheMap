//
//  LogoutRequest.swift
//  On The Map
//
//  Created by Renan Baialuna on 25/04/21.
//

import Foundation

struct LogoutRequest: Codable {
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
    }
}
