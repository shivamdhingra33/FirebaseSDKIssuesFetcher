//
//  BaseRouter.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import Foundation
import Alamofire

enum BaseRouter: URLRequestConvertible {
    case issuesBaseRouter(IssuesRouter)
    
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .issuesBaseRouter(let router):
            return configureRequest(router)
        }
    }
    
    func configureRequest(_ router: RoutingProtocol) -> URLRequest {
        let urlString = APIConstants.baseURL + router.path
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        if let headers = router.headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        request.httpMethod = router.method.rawValue
        request = (try? Alamofire.URLEncoding.queryString.encode(request, with: router.params)) ?? request
        return request
    }
}
