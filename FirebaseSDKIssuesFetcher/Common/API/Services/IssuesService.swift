//
//  IssuesService.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import Foundation

class IssuesService {
    class func fetchIssues<T: Codable>(of type: T.Type, params: PathParams, completionHandler: @escaping (NetworkResponse<T>) -> Void) {
        NetworkAdapter.request(BaseRouter.issuesBaseRouter(IssuesRouter.fetchIssues(params)).urlRequest!) { (response: NetworkResponse<T>) in
            completionHandler(response)
        }
    }
    
    class func fetchComments<T: Codable>(of type: T.Type, id: Int, completionHandler: @escaping (NetworkResponse<T>) -> Void) {
        NetworkAdapter.request(BaseRouter.issuesBaseRouter(IssuesRouter.fetchComments(id)).urlRequest!) { (response: NetworkResponse<T>) in
            completionHandler(response)
        }
    }
}
