//
//  ActorMoviesCell.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 23/03/2021.
//

import UIKit

class ActorMoviesCell: UITableViewCell {
    var actorMoviePoster = UIImageView()
    var actorMovieTitleLbl = UILabel()
    var actorMovieYearLbl = UILabel()
    var actorMovieTextLbl = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configMoviePoster()
        configActorMovieTitleLbl()
        configActorMovieYearLbl()
        configActorMovieTextField()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       func configMoviePoster() {
        contentView.addSubview(actorMoviePoster)
        actorMoviePoster.image = UIImage(named: "7m")
        actorMoviePoster.layer.cornerRadius = 8
        actorMoviePoster.clipsToBounds = true
        actorMoviePoster.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actorMoviePoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            actorMoviePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            actorMoviePoster.widthAnchor.constraint(equalToConstant: 110),
            actorMoviePoster.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    func configActorMovieTitleLbl () {
        contentView.addSubview(actorMovieTitleLbl)
        actorMovieTitleLbl.text = "Title of Movie"
        actorMovieTitleLbl.textColor = .label
        actorMovieTitleLbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        actorMovieTitleLbl.lineBreakMode = .byWordWrapping
        actorMovieTitleLbl.numberOfLines = 0
        actorMovieTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actorMovieTitleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            actorMovieTitleLbl.leadingAnchor.constraint(equalTo: actorMoviePoster.trailingAnchor, constant: 5),
            actorMovieTitleLbl.widthAnchor.constraint(equalToConstant: 200),
            actorMovieTitleLbl.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    func configActorMovieYearLbl() {
        contentView.addSubview(actorMovieYearLbl)
        actorMovieYearLbl.text = "Year"
        actorMovieYearLbl.textColor = .systemGray
        actorMovieYearLbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        actorMovieTextLbl.numberOfLines = 0
        actorMovieYearLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actorMovieYearLbl.topAnchor.constraint(equalTo: actorMovieTitleLbl.bottomAnchor, constant: 5),
            actorMovieYearLbl.leadingAnchor.constraint(equalTo: actorMoviePoster.trailingAnchor, constant: 5),
            actorMovieYearLbl.widthAnchor.constraint(equalToConstant: 100),
            actorMovieYearLbl.heightAnchor.constraint(equalToConstant: 14)
        ])
    }
    func configActorMovieTextField() {
        contentView.addSubview(actorMovieTextLbl)
        actorMovieTextLbl.textColor = .label
        actorMovieTextLbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        actorMovieTextLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actorMovieTextLbl.topAnchor.constraint(equalTo: actorMovieYearLbl.bottomAnchor, constant: 5),
            actorMovieTextLbl.leadingAnchor.constraint(equalTo: actorMoviePoster.trailingAnchor, constant: 10),
            actorMovieTextLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            actorMovieTextLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
        ])
    }
}
