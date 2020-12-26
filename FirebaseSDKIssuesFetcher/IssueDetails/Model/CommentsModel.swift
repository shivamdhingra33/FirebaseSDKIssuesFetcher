//
//  CommentsModel.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import Foundation

class CommentsModel: Codable {
    var id: Int?
    var body: String?
    var createdAt: String?
    var user: User?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id, body, user
    }
}

class User: Codable {
    var id: Int?
    var avatarUrl: String?
    var login: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case id, login
    }
}
