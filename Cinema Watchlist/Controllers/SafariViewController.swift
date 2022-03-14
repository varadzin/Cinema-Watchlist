//
//  SafariViewController.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 25/04/2021.
//

import UIKit
import SafariServices

extension UIViewController {
func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemBlue
        present(safariVC, animated: true)
    }
}
