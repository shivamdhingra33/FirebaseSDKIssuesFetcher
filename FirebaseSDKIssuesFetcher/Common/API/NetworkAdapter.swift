//
//  NetworkAdapter.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import Foundation
import Alamofire

typealias NetworkResponse<T> = Result<T,Error>

class NetworkAdapter {
    class func request<T: Codable>(_ request: URLRequest, completionHandler: @escaping (NetworkResponse<T>) -> Void) {
        
        if let response = CustomCacheHandler.shared.getCachedResponse(forRequest: request), let cachedAt = response.userInfo?["cachedAt"] as? Date, cachedAt.isLessThan24Hrs {
            
            let data = response.data
            if let cacheResponse = try? JSONDecoder().decode(T.self, from: data) {
                completionHandler(.success(cacheResponse))
                return
            }
        }
        
        AF.request(request).validate().responseDecodable(of: T.self) { (response) in
            switch response.result {
            case .success(let response):
                completionHandler(.success(response))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }.cURLDescription { (cURL) in
            print(cURL)
        }.cacheResponse(using: CustomCacheHandler.shared)
    }
}

class CustomCacheHandler: CachedResponseHandler {
    
    static let shared = CustomCacheHandler()
    
    private init () {}
    
    func dataTask(_ task: URLSessionDataTask, willCacheResponse response: CachedURLResponse, completion: @escaping (CachedURLResponse?) -> Void) {
        let modifiedResponse = CachedURLResponse(response: response.response, data: response.data, userInfo: ["cachedAt": Date()], storagePolicy: .allowed)
        if let request = task.originalRequest, request.method == .get {
            URLCache.shared.storeCachedResponse(modifiedResponse, for: request)
        }
        completion(modifiedResponse)
    }
    
    func getCachedResponse(forRequest request: URLRequest) -> CachedURLResponse? {
        return URLCache.shared.cachedResponse(for: request)
    }
}

extension Date {
    var isLessThan24Hrs: Bool {
        let comparizon1 = Calendar.current.compare(self, to: Date(), toGranularity: .minute)
        let date24HrBefore = Calendar.current.date(byAdding: DateComponents(hour: -24), to: Date()) ?? Date()
        let comparizon2 = Calendar.current.compare(self, to: date24HrBefore, toGranularity: .minute)
        if (comparizon1 == .orderedAscending || comparizon1 == .orderedSame) && comparizon2 == .orderedDescending {
            return true
        }
        return false
    }
}
