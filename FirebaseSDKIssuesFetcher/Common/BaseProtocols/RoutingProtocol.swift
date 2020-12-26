//
//  RoutingProtocol.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import Foundation
import Alamofire

typealias RequestHeaders = [String: String]
typealias PathParams = Parameters

protocol RoutingProtocol {
    var method: HTTPMethod {get}
    var path: String {get}
    var headers: RequestHeaders? {get}
    var params: PathParams? {get}
}
