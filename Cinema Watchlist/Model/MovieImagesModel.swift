//
//  MovieImagesModel.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 28/03/2021.
//

import Foundation

struct MovieImagesModel: Decodable {
    let images: [MovieImages]
    private enum CodingKeys: String, CodingKey {
        case images = "backdrops"
    }
}
struct MovieImages: Decodable {
    let movieImage: String?
    private enum CodingKeys: String, CodingKey {
        case movieImage = "file_path"
    }
}
