//
//  IssueDetailsViewModel.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import Foundation

protocol IssueDetailsViewModelDelegate: AnyObject {
    func issueDetailsViewModel(_ viewModel: IssueDetailsViewModel, successfullyFetchedData: Any?)
    func issueDetailsViewModel(_ viewModel: IssueDetailsViewModel, failedWithError error: Error)
}

class IssueDetailsViewModel {
    var title = "Comments on Issue"
    var issue: IssuesListingModel
    var comments: [CommentsModel]?
    weak var viewDelegate: IssueDetailsViewModelDelegate?
    
    init(issue: IssuesListingModel) {
        self.issue = issue
    }
}

extension IssueDetailsViewModel {
    func fetchComments() {
        IssuesService.fetchComments(of: [CommentsModel].self, id: issue.id ?? 0) {[weak self] (response) in
            if let _StrongSelf = self {
                switch response {
                case .success(let commentsList):
                    _StrongSelf.comments = commentsList
                    _StrongSelf.viewDelegate?.issueDetailsViewModel(_StrongSelf, successfullyFetchedData: nil)
                case .failure(let error):
                    _StrongSelf.viewDelegate?.issueDetailsViewModel(_StrongSelf, failedWithError: error)
                }
            }
        }
    }
}
