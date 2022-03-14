//
//  MovieMoreDetails2.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 15/03/2021.
//

import Foundation

struct MovieMoreDetails2: Codable {
let overview: String
    let budget: Int
    let revenue: Int
    let genres: [Genres]
    let poster_path: String
    let backdrop_path: String?
    let original_language: String
    let popularity: Float
    let runtime: Int
    let vote_average: Float
    let release_date: String
}
struct Genres: Codable {
    let name: String
}
