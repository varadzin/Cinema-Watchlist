//
//  ActorImagesCollectionViewCell.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 28/03/2021.
//

import UIKit

class ActorImagesCollectionViewCell: UICollectionViewCell {
    static let reuseID = "ActorMovieCell"
    var actorImagePoster = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configCell() {
        addSubview(actorImagePoster)
        actorImagePoster.layer.cornerRadius = 8
        actorImagePoster.clipsToBounds = true
        actorImagePoster.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actorImagePoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            actorImagePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            actorImagePoster.widthAnchor.constraint(equalToConstant: 140),
            actorImagePoster.heightAnchor.constraint(equalToConstant: 190)
        ])
    }
}
