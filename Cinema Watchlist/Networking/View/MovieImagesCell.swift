//
//  MovieImagesCell.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 28/03/2021.
//

import UIKit

class MovieImagesCell: UICollectionViewCell {
    static let reuseID = "MovieImagesCell"
    var movieImage = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configCell() {
        addSubview(movieImage)
        movieImage.layer.cornerRadius = 8
        movieImage.clipsToBounds = true
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieImage.widthAnchor.constraint(equalToConstant: 330),
            movieImage.heightAnchor.constraint(equalToConstant: 190)
        ])
    }
}
