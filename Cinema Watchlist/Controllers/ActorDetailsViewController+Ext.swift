//
//  ActorDetailsViewContoller+Ext.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 06/03/2021.
//

import UIKit

extension ActorDetailsViewContoller {
    func configViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = actorName
    }
    // MARK: - shadow under Actor Poster
    func configShadow() {
        scrollView.addSubview(shadow)
        shadow.image = UIImage(named: "shadow")
        shadow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadow.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -30),
            shadow.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            shadow.widthAnchor.constraint(equalToConstant: 195),
            shadow.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
    func configActorPoster() {
        scrollView.addSubview(actorPoster)
        actorPoster.layer.cornerRadius = 10
        actorPoster.clipsToBounds = true
        actorPoster.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actorPoster.topAnchor.constraint(equalTo: scrollView.topAnchor),
            actorPoster.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            actorPoster.widthAnchor.constraint(equalToConstant: 160),
            actorPoster.heightAnchor.constraint(equalToConstant: 230)
        ])
    }
    func configActorBio() {
        scrollView.addSubview(biographyLbl)
        biographyLbl.font = UIFont.systemFont(ofSize: 16)
        biographyLbl.backgroundColor = .systemBackground
        biographyLbl.clipsToBounds = true
        biographyLbl.textColor = .label
        biographyLbl.isUserInteractionEnabled = false
        biographyLbl.isScrollEnabled = false
        biographyLbl.textAlignment = .justified
        biographyLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            biographyLbl.topAnchor.constraint(equalTo: actorPoster.bottomAnchor, constant: 10),
            biographyLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            biographyLbl.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 15/16)
        ])
    }
    func configScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height + 400)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    func configFilmBtn() {
        scrollView.addSubview(filmographyButton)
        filmographyButton.setBackgroundImage(UIImage(named: "filmBtn"), for: .normal)
        filmographyButton.setBackgroundImage(UIImage(named: "filmBtnTpd"), for: .highlighted)
        filmographyButton.addTarget(self, action: #selector(filmBtnTapped), for: .touchUpInside)
        filmographyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmographyButton.topAnchor.constraint(equalTo: actorPoster.topAnchor, constant: 80),
            filmographyButton.leadingAnchor.constraint(equalTo: actorPoster.trailingAnchor, constant: 15),
            filmographyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            filmographyButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    func configFavBtn() {
        scrollView.addSubview(favButton)
        if favActorId.contains(actorIdentity) {
            favButton.setBackgroundImage(UIImage(named: "addFavBtnTpd"), for: .normal)
        } else {
            favButton.setBackgroundImage(UIImage(named: "addFavBtn"), for: .normal)
        }
        favButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        favButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favButton.bottomAnchor.constraint(equalTo: actorPoster.bottomAnchor, constant: 6),
            favButton.leadingAnchor.constraint(equalTo: actorPoster.trailingAnchor, constant: 55),
            favButton.widthAnchor.constraint(equalToConstant: 75),
            favButton.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    func configImagesBtn() {
        scrollView.addSubview(imagesBtn)
        imagesBtn.addTarget(self, action: #selector(imagesBtnTapped), for: .touchUpInside)
        imagesBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagesBtn.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imagesBtn.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            imagesBtn.widthAnchor.constraint(equalToConstant: 160),
            imagesBtn.heightAnchor.constraint(equalToConstant: 230)
        ])
    }
    @objc func imagesBtnTapped() {
        let destVC = ActorImagesCollectionVC()
        destVC.actorId = actorIdentity
        destVC.title = actorName
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}
