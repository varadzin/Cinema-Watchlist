//
// MoviesDetailsModel.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 11/04/2021.
//

import Foundation

struct MovieDetailsModel: Decodable {
    let movies: [MovieDetails]
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
struct MovieDetails: Decodable {
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    let id: Int?
    let popularity: Float?
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
        case id = "id"
        case popularity = "popularity"
    }
}
