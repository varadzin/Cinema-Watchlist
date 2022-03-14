//
//  ActorsTableViewCell.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 27/03/2021.
//

import UIKit

class ActorsTableViewCell: UITableViewCell {
    var actorPoster = UIImageView()
    var actorsPosterValue = String()
    var actorsNameLbl = UILabel()
    var actorsNameValue = String()
    var actorsCharacterLbl = UILabel()
    var actorsCharacterValue = String()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configActorsPoster()
        configActorsName()
        configActorsCharacter()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configActorsPoster() {
        addSubview(actorPoster)
        actorPoster.layer.cornerRadius = 8
        actorPoster.clipsToBounds = true
        actorPoster.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actorPoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            actorPoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            actorPoster.heightAnchor.constraint(equalToConstant: 145),
            actorPoster.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    func configActorsName() {
        addSubview(actorsNameLbl)
        actorsNameLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        actorsNameLbl.textColor = .label
        actorsNameLbl.allowsDefaultTighteningForTruncation = true
        actorsNameLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actorsNameLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            actorsNameLbl.leadingAnchor.constraint(equalTo: actorPoster.trailingAnchor, constant: 5),
            actorsNameLbl.widthAnchor.constraint(equalToConstant: 265),
            actorsNameLbl.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    func configActorsCharacter() {
        addSubview(actorsCharacterLbl)
        actorsCharacterLbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        actorsCharacterLbl.textColor = .label
        actorsCharacterLbl.numberOfLines = 0
        actorsCharacterLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actorsCharacterLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            actorsCharacterLbl.leadingAnchor.constraint(equalTo: actorPoster.trailingAnchor, constant: 5),
            actorsCharacterLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            actorsCharacterLbl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
