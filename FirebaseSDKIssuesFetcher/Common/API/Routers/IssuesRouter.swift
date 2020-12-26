//
//  IssuesRouter.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import Foundation
import Alamofire

enum IssuesRouter: RoutingProtocol {
    case fetchIssues(PathParams)
    case fetchComments(Int)
    
    var path: String {
        switch self {
        case .fetchIssues:
            return APIConstants.fetchIssues
        case .fetchComments(let id):
            return String.localizedStringWithFormat(APIConstants.fetchComments, id)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchIssues:
            return .get
        case .fetchComments:
            return .get
        }
    }
    
    var headers: RequestHeaders? {
        return nil
    }
    
    var params: PathParams? {
        switch self {
        case .fetchIssues(let params):
            return params
        default:
            return nil
        }
    }
}
