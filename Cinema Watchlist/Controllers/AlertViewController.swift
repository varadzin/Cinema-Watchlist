//
//  AlertViewController.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 18/05/2021.
//

import UIKit

class AlertViewController: UIViewController {
    let containerView = UIView()
    let titleLabel =  UILabel()
    let messageLabel  = UILabel()
    let actionButton = UIButton()
    var alertTitle: String?
    var messageText: String?
    var buttonTitle: String?
    var padding: CGFloat = 20
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.messageText = message
        self.buttonTitle = buttonTitle
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configContainer()
        configTitleLbl()
        configButton()
        configMessageLbl()
    }
    func configContainer() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemBlue.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 280)
        ])
        }
    func configTitleLbl() {
        view.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        titleLabel.tintColor = .label
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .systemBackground
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    func configButton() {
        view.addSubview(actionButton)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.backgroundColor = .systemBlue
        actionButton.layer.cornerRadius = 10
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    func configMessageLbl() {
        view.addSubview(messageLabel)
        messageLabel.text = messageText ?? "Unable to complete request"
        messageLabel.numberOfLines = 3
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 22)
        messageLabel.backgroundColor = .systemBackground
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -padding)
        ])
    }
}
