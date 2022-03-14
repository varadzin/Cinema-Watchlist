//
//  ActorMoviesDetailsModel.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 06/03/2021.
//

import Foundation

struct ActorMoviesDetailsModel: Decodable {
    let actorMovies: [ActorMoviesDetails]
    private enum CodingKeys: String, CodingKey {
        case actorMovies = "cast"
    }
}
struct ActorMoviesDetails: Decodable {
    let title: String?
    let year: String?
    let posterImage: String?
    let overview: String?
    let id: Int?
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case posterImage = "poster_path"
        case id = "id"
    }
}
