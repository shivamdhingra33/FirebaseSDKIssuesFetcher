//
//  IssuesListingViewController.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import UIKit

class IssuesListingViewController: UIViewController, ViewFromNib {
    
    //MARK: - IBOutlets
    @IBOutlet var tvTableView: UITableView!
    
    //MARK: - Properties
    var viewModel: IssuesListingViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    lazy var loaderView: LoaderView = {
        let loadingView = LoaderView(frame: CGRect(x: 0, y: 0, width: tvTableView.frame.width, height: 100))
        return loadingView
    }()
    var isLoading: Bool = false {
        didSet {
            checkLoading()
        }
    }

    //MARK: - App cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        configureView()
    }
    
    //MARK: - Private Methods
    private func setupNavbar() {
        title = viewModel.title
    }
    
    private func configureView() {
        IssuesListingTableViewCell.registerCell(forTableView: tvTableView)
        tvTableView.delegate = self
        tvTableView.dataSource = self
        isLoading = true
        viewModel.fetchIssues()
    }
    
    private func checkLoading() {
        if isLoading {
            tvTableView.tableFooterView = loaderView
            loaderView.startLoading()
        }
        else {
            loaderView.stopLoading()
            tvTableView.tableFooterView = UIView()
        }
    }
}

//MARK: - IssuesListingViewModelDelegate
extension IssuesListingViewController: IssuesListingViewModelDelegate {
    func issuesListingViewModel(_ viewModel: IssuesListingViewModel, successfullyFetchedIssues: Any?) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.tvTableView.reloadData()
        }
    }
    
    func issuesListingViewModel(_ viewModel: IssuesListingViewModel, failedWithError error: Error) {
        DispatchQueue.main.async {
            self.isLoading = false
            AlertUtil.show(error: error, target: self)
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension IssuesListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.issues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = IssuesListingTableViewCell.dequeueCell(forTableView: tableView, indexPath: indexPath)
        cell.configureCell(withIssue: viewModel.issues?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = IssueDetailsViewController.viewController(), let issue = viewModel.issues?[indexPath.row] {
            viewController.viewModel = IssueDetailsViewModel(issue: issue)
            self.show(viewController, sender: self)
        }
    }
}
