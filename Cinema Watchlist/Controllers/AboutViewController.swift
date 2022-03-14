//
//  AboutViewController.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 25/04/2021.
//

import UIKit
import MessageUI
class AboutViewController: UIViewController, MFMailComposeViewControllerDelegate {
    var TMDBlogo = UIImageView()
    var textLbl = UILabel()
    var authorLbl = UILabel()
    var githubBtn = UIButton()
    var emailBtn = UIButton()
    var twitterBtn = UIButton()
    var personalSiteBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "About the App"
        configLogo()
        configTextLbl()
        configDoneBtn()
        configAuthorLbl()
        configGithubBtn()
        configEmailBtn()
        configTwitterBtn()
        confiPersonalSiteBtn()
    }
    func configLogo() {
        view.addSubview(TMDBlogo)
        TMDBlogo.image = UIImage(named: "LogoTMDB")
        TMDBlogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            TMDBlogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            TMDBlogo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    func configTextLbl() {
        view.addSubview(textLbl)
        textLbl.text = "This product uses the TMDb API but is not endorsed or certified by TMDb."
        textLbl.textColor = .label
        textLbl.textAlignment = .center
        textLbl.numberOfLines = 0
        textLbl.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        textLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLbl.topAnchor.constraint(equalTo: TMDBlogo.bottomAnchor, constant: 30),
            textLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    func configDoneBtn() {
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBtn
    }
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    func confiPersonalSiteBtn() {
        view.addSubview(personalSiteBtn)
        personalSiteBtn.addTarget(self, action: #selector(nameTapped), for: .touchUpInside)
        personalSiteBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personalSiteBtn.topAnchor.constraint(equalTo: textLbl.bottomAnchor, constant: 40),
            personalSiteBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            personalSiteBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            personalSiteBtn.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    @objc func nameTapped() {
        let myUrl = "https://www.varadzin.com"
        let url = URL(string: myUrl)
        presentSafariVC(with: url!)
    }
    func configAuthorLbl() {
        view.addSubview(authorLbl)
        authorLbl.text = "Author:\nFrantisek Varadzin\n\nhttps://varadzin.com"
        authorLbl.textColor = .label
        authorLbl.textAlignment = .center
        authorLbl.numberOfLines = 0
        authorLbl.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        authorLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorLbl.topAnchor.constraint(equalTo: textLbl.bottomAnchor, constant: 40),
            authorLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            authorLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            authorLbl.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    func configGithubBtn() {
        view.addSubview(githubBtn)
        githubBtn.setImage(UIImage(named: "gitHubLogo"), for: .normal)
        githubBtn.addTarget(self, action: #selector(btnGithubTapped), for: .touchUpInside)
        githubBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            githubBtn.topAnchor.constraint(equalTo: authorLbl.bottomAnchor, constant: 30),
            githubBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            githubBtn.widthAnchor.constraint(equalToConstant: 50),
            githubBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc func btnGithubTapped() {
        let myUrl = "https://github.com/varadzin"
        let url = URL(string: myUrl)
        presentSafariVC(with: url!)
    }
    func configEmailBtn() {
        view.addSubview(emailBtn)
        emailBtn.setImage(UIImage(named: "EmailLogo"), for: .normal)
        emailBtn.addTarget(self, action: #selector(btnEmailTapped), for: .touchUpInside)
        emailBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailBtn.topAnchor.constraint(equalTo: authorLbl.bottomAnchor, constant: 30),
            emailBtn.trailingAnchor.constraint(equalTo: githubBtn.leadingAnchor, constant: -20),
            emailBtn.widthAnchor.constraint(equalToConstant: 50),
            emailBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc func btnEmailTapped() {
        sendEmail()
    }
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["varadzin@gmail.com"])
            mail.setSubject("Message from App User")
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {controller.dismiss(animated: true)
    }
    func configTwitterBtn() {
        view.addSubview(twitterBtn)
        twitterBtn.setImage(UIImage(named: "logoTwitter"), for: .normal)
        twitterBtn.addTarget(self, action: #selector(btnTwitterTapped), for: .touchUpInside)
        twitterBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            twitterBtn.topAnchor.constraint(equalTo: authorLbl.bottomAnchor, constant: 30),
            twitterBtn.leadingAnchor.constraint(equalTo: githubBtn.trailingAnchor, constant: 20),
            twitterBtn.widthAnchor.constraint(equalToConstant: 50),
            twitterBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc func btnTwitterTapped() {
        let myUrl = "https://twitter.com/DevHannover"
        let url = URL(string: myUrl)
        presentSafariVC(with: url!)
    }
}
