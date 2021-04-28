//
//  UserInformationComplete.swift
//  On The Map
//
//  Created by Renan Baialuna on 26/04/21.
//

import Foundation

struct UserInformationComplete: Codable {
    let lastName: String
    let socialAccounts, mailingAddress, cohortKeys, badges, principals, enrollments, tags, affiliateProfiles, externalAccounts, memberships: [String]?
    let signature, stripeCustomerID, facebookID, timezone, sitePreferences, occupation, firstName, image, jabberID, languages, location, externalServicePassword, websiteURL, bio, coachingData, emailPreferences, resume, zendeskID, key, nickname, linkedinURL, googleID, imageURL: String?
    let userInformationCompleteGuard: Guard
    let email: Email
    let hasPassword, employerSharing, registered: Bool

    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case socialAccounts = "social_accounts"
        case mailingAddress = "mailing_address"
        case cohortKeys = "_cohort_keys"
        case signature
        case stripeCustomerID = "_stripe_customer_id"
        case userInformationCompleteGuard = "guard"
        case facebookID = "_facebook_id"
        case timezone
        case sitePreferences = "site_preferences"
        case occupation
        case image = "_image"
        case firstName = "first_name"
        case jabberID = "jabber_id"
        case languages
        case badges = "_badges"
        case location
        case externalServicePassword = "external_service_password"
        case principals = "_principals"
        case enrollments = "_enrollments"
        case email
        case websiteURL = "website_url"
        case externalAccounts = "external_accounts"
        case bio
        case coachingData = "coaching_data"
        case tags
        case affiliateProfiles = "_affiliate_profiles"
        case hasPassword = "_has_password"
        case emailPreferences = "email_preferences"
        case resume = "_resume"
        case key, nickname
        case employerSharing = "employer_sharing"
        case memberships = "_memberships"
        case zendeskID = "zendesk_id"
        case registered = "_registered"
        case linkedinURL = "linkedin_url"
        case googleID = "_google_id"
        case imageURL = "_image_url"
    }
}

// MARK: - Email
struct Email: Codable {
    let address: String
    let verified, verificationCodeSent: Bool

    enum CodingKeys: String, CodingKey {
        case address
        case verified = "_verified"
        case verificationCodeSent = "_verification_code_sent"
    }
}

// MARK: - Guard
struct Guard: Codable {
}
