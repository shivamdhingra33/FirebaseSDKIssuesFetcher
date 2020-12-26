//
//  IssueDetailsTableViewCell.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 27/12/20.
//

import UIKit
import Kingfisher

class IssueDetailsTableViewCell: UITableViewCell, ViewFromNib {
    
    //MARK: - IBOutlets
    @IBOutlet var ivProfileImageView: UIImageView!
    @IBOutlet var lTitleLabel: UILabel!
    @IBOutlet var lDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Methods
    func configureCell(withComment comment: CommentsModel?) {
        lTitleLabel.text = comment?.user?.login
        lDescriptionLabel.text = comment?.body
        if let urlString = comment?.user?.avatarUrl, let url = URL(string: urlString) {
            ivProfileImageView.kf.indicatorType = .activity
            ivProfileImageView.kf.setImage(with: url)
        } else {
            ivProfileImageView.image = UIImage(named: "profileImage")
        }
    }
}
