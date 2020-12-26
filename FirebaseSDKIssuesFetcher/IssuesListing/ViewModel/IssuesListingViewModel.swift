//
//  IssuesListingViewModel.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import Foundation

protocol IssuesListingViewModelDelegate: AnyObject {
    func issuesListingViewModel(_ viewModel: IssuesListingViewModel, successfullyFetchedIssues: Any?)
    func issuesListingViewModel(_ viewModel: IssuesListingViewModel, failedWithError error: Error)
}

class IssuesListingViewModel {
    var title = "List Of Issues"
    var issues: [IssuesListingModel]?
    weak var viewDelegate: IssuesListingViewModelDelegate?
}

extension IssuesListingViewModel {
    func fetchIssues() {
        let params = [
            "sort": "updated",
            "direction": "desc"
        ]
        IssuesService.fetchIssues(of: [IssuesListingModel].self, params: params) {[weak self] (response) in
            if let _StrongSelf = self {
                switch response {
                case .success(let result):
                    _StrongSelf.issues = result
                    _StrongSelf.viewDelegate?.issuesListingViewModel(_StrongSelf, successfullyFetchedIssues: nil)
                case .failure(let error):
                    _StrongSelf.viewDelegate?.issuesListingViewModel(_StrongSelf, failedWithError: error)
                }
            }
        }
    }
}
