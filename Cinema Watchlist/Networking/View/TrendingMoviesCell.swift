//
//  TrendingMoviesCell.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 11/04/2021.
//

import UIKit

class TrendingMoviesCell: UICollectionViewCell {
    static let reuseID = "TrendingMoviesCell"
    var favoritesPoster = UIImageView()
    var favoritesMovieLbl = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configFavoritesCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configFavoritesCell() {
        addSubviews(favoritesPoster, favoritesMovieLbl)
        favoritesPoster.layer.cornerRadius = 10
        favoritesPoster.clipsToBounds = true
        favoritesPoster.image = UIImage(named: "moviePlaceholder")
        favoritesMovieLbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        favoritesMovieLbl.textAlignment = .center
        favoritesMovieLbl.numberOfLines = 0
        favoritesMovieLbl.adjustsFontSizeToFitWidth = true
        favoritesPoster.translatesAutoresizingMaskIntoConstraints = false
        favoritesMovieLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoritesPoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            favoritesPoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            favoritesPoster.widthAnchor.constraint(equalToConstant: 140),
            favoritesPoster.heightAnchor.constraint(equalToConstant: 190),
            favoritesMovieLbl.topAnchor.constraint(equalTo: favoritesPoster.bottomAnchor, constant: 2),
            favoritesMovieLbl.centerXAnchor.constraint(equalTo: favoritesPoster.centerXAnchor),
            favoritesMovieLbl.widthAnchor.constraint(equalToConstant: 140),
            favoritesMovieLbl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
