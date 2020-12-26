//
//  IssuesListingTableViewCell.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import UIKit

class IssuesListingTableViewCell: UITableViewCell, ViewFromNib {
    
    //MARK: - IBOutlets
    @IBOutlet var lTitleLabel: UILabel!
    @IBOutlet var lBodyLabel: UILabel!
    @IBOutlet var ivProfileImageView: UIImageView!
    @IBOutlet var lUpdatedAtLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(withIssue issue: IssuesListingModel?) {
        lTitleLabel.text = issue?.title
        if let body = issue?.body {
            let startIndex = body.startIndex
            if body.count > 140 {
                let endIndex = body.index(startIndex, offsetBy: 140)
                lBodyLabel.text = String(body[startIndex..<endIndex])
            }
            else {
                lBodyLabel.text = body
            }
        }
        else {
            lBodyLabel.text = ""
        }
        if let urlString = issue?.user?.avatarUrl, let url = URL(string: urlString) {
            ivProfileImageView.kf.indicatorType = .activity
            ivProfileImageView.kf.setImage(with: url)
        } else {
            ivProfileImageView.image = UIImage(named: "profileImage")
        }
        lUpdatedAtLabel.text = issue?.updated
    }
    
}
