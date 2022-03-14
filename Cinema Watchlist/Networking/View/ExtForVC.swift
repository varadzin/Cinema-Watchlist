//
//  ExtForVC.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 18/05/2021.
//  Extension is used by Alert window for all View Controllers

import UIKit

extension UIViewController {
    func uniAlertVC(title: String, message: String, buttonTitle: String) {
        let alertVC = AlertViewController(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true, completion: nil)
    }
}
