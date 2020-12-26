//
//  AlertUtil.swift
//  FirebaseSDKIssuesFetcher
//
//  Created by Shivam Dhingra on 26/12/20.
//

import Foundation
import UIKit

class AlertUtil {
    static func show(error: Error, target: UIViewController, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        target.present(alert, animated: true, completion: nil)
    }
}
