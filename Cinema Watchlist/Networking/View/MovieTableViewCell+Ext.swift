//
//  MovieTableViewCell+Ext.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 14/03/2021.
//

import UIKit

extension MovieTableViewCell {
    func configMovieImg() {
        addSubview(moviePoster)
        moviePoster.layer.cornerRadius = 8
        moviePoster.clipsToBounds = true
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            moviePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            moviePoster.heightAnchor.constraint(equalToConstant: 145),
            moviePoster.widthAnchor.constraint(equalToConstant: 110)
        ])
    }
    func configMovieTitle() {
        addSubview(movieTitle)
        movieTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        movieTitle.textColor = .label
        movieTitle.lineBreakMode = .byWordWrapping
        movieTitle.numberOfLines = 0
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            movieTitle.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 5),
            movieTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            movieTitle.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    func configMovieDate() {
        addSubview(movieYear)
        movieYear.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        movieYear.textColor = .systemGray2
        movieYear.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieYear.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 2),
            movieYear.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 5),
            movieYear.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            movieYear.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
    func configMovieDescr() {
        contentView.addSubview(movieOverview)
        movieOverview.font = UIFont.systemFont(ofSize: 12, weight: .light)
        movieOverview.textColor = .label
        movieOverview.numberOfLines = 0
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieOverview.topAnchor.constraint(equalTo: movieYear.bottomAnchor, constant: 5),
            movieOverview.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 5),
            movieOverview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            movieOverview.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
