//
//  LoaderView.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 27/12/20.
//

import UIKit

class LoaderView: UIView {

    lazy var aiLoaderActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(aiLoaderActivityIndicator)
        NSLayoutConstraint.activate([
            aiLoaderActivityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            aiLoaderActivityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoading() {
        aiLoaderActivityIndicator.startAnimating()
    }
    
    func stopLoading() {
        aiLoaderActivityIndicator.stopAnimating()
    }
    
}
