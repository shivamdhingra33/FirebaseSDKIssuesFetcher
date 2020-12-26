//
//  IssueDetailsViewController.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import UIKit

class IssueDetailsViewController: UIViewController, ViewFromNib {
    
    //MARK: - IBOutlets
    @IBOutlet var tvTableView: UITableView!

    //MARK: - Properties
    var viewModel: IssueDetailsViewModel! {
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

        // Do any additional setup after loading the view.
        setupNavbar()
        configureView()
    }
    
    //MARK: - Private Methods
    private func setupNavbar() {
        title = viewModel.title
    }
    
    private func configureView() {
        tvTableView.delegate = self
        tvTableView.dataSource = self
        IssueDetailsTableViewCell.registerCell(forTableView: tvTableView)
        configureHeaderView()
        isLoading = true
        viewModel.fetchComments()
    }
    
    private func configureHeaderView() {
        if let headerView = IssueDetailsTableHeaderView.view() {
            let containerView = UIView()
            headerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(headerView)
            
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: headerView.topAnchor),
                containerView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
                containerView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor)
            ])
            
            headerView.configureView(withIssue: viewModel.issue)
            tvTableView.tableHeaderView = containerView
            
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: tvTableView.topAnchor),
                containerView.leadingAnchor.constraint(equalTo: tvTableView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: tvTableView.trailingAnchor),
                containerView.centerXAnchor.constraint(equalTo: tvTableView.centerXAnchor)
            ])
            
            tvTableView.tableHeaderView?.layoutIfNeeded()
            tvTableView.tableHeaderView = tvTableView.tableHeaderView
        }
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

//MARK: - IssueDetailsViewModelDelegate
extension IssueDetailsViewController: IssueDetailsViewModelDelegate {
    func issueDetailsViewModel(_ viewModel: IssueDetailsViewModel, successfullyFetchedData: Any?) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.tvTableView.reloadData()
        }
    }
    
    func issueDetailsViewModel(_ viewModel: IssueDetailsViewModel, failedWithError error: Error) {
        DispatchQueue.main.async {
            self.isLoading = false
            AlertUtil.show(error: error, target: self)
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension IssueDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = IssueDetailsTableViewCell.dequeueCell(forTableView: tableView, indexPath: indexPath)
        cell.configureCell(withComment: viewModel.comments?[indexPath.row])
        return cell
    }
}
