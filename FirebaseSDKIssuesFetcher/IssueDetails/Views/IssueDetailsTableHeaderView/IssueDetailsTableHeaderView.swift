//
//  IssueDetailsTableHeaderView.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 27/12/20.
//

import UIKit

class IssueDetailsTableHeaderView: UIView, ViewFromNib {

    //MARK: - IBOutlets
    @IBOutlet var lTitleLabel: UILabel!
    @IBOutlet var lBodyLabel: UILabel!
    @IBOutlet var lCreatedByLabel: UILabel!
    @IBOutlet var lStatusLabel: UILabel!
    @IBOutlet var ivProfileImageView: UIImageView!
    @IBOutlet var lUpdatedAtLabel: UILabel!
    
    //MARK: - Methods
    func configureView(withIssue issue: IssuesListingModel) {
        lTitleLabel.text = issue.title
        lBodyLabel.text = issue.body
        lCreatedByLabel.text = "By: \(issue.user?.login ?? "")"
        lStatusLabel.text = issue.state
        if let urlString = issue.user?.avatarUrl, let url = URL(string: urlString) {
            ivProfileImageView.kf.indicatorType = .activity
            ivProfileImageView.kf.setImage(with: url)
        } else {
            ivProfileImageView.image = UIImage(named: "profileImage")
        }
        lUpdatedAtLabel.text = issue.updated
    }

}
