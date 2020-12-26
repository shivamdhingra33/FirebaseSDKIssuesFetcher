//
//  IssuesListingModel.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import Foundation

class IssuesListingModel: Codable {
    var id: Int?
    var number: Int?
    var state: String?
    var title: String?
    var body: String?
    var user: User?
    var updatedAt: String?
    
    var updated: String? {
        let dateFormatter1 = DateFormatter()
        let dateFormatter2 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter2.dateFormat = "d MMM yyyy, hh:mm a"
        let date = dateFormatter1.date(from: updatedAt ?? "")
        let dateString = dateFormatter2.string(from: date ?? Date())
        return dateString
    }
    
    enum CodingKeys: String, CodingKey {
        case id, number, state, title, body, user
        case updatedAt = "updated_at"
    }
}
