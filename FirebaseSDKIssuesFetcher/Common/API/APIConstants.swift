//
//  APIConstants.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import Foundation

class APIConstants {
    static let baseURL = "https://api.github.com/repos/firebase/firebase-ios-sdk"
    
    static let fetchIssues = "/issues"
    static let fetchComments = "/issues/%d/comments"
}
