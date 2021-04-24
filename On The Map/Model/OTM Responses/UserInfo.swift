//
//  userData.swift
//  On The Map
//
//  Created by Renan Baialuna on 21/04/21.
//

import Foundation


struct UserInfo: Codable {
    let account: Account
    let session: Session
}

// MARK: - Account
struct Account: Codable {
    let registered: Bool
    let key: String
}

// MARK: - Session
struct Session: Codable {
    let id, expiration: String
}

struct SessionData: Codable {
    let session: Session
}

struct LogoutRequest: Codable {
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
    }
}
