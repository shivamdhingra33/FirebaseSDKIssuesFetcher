//
//  AppDelegate.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        if let viewController = IssuesListingViewController.viewController() {
            viewController.viewModel = IssuesListingViewModel()
            let navController = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
        }
        return true
    }


}

