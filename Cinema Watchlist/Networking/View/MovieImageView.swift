//
//  MovieImageView.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 12/03/2021.
//

import UIKit

class MovieImageView: UIImageView {
    let placeholderImage = UIImage(named: "moviePlaceholder")
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
