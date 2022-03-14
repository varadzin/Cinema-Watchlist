//
//  ActorDetailsModel.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 27/02/2021.
//

import Foundation

struct ActorDetailsModel: Decodable {
    let actors: [ActorDetails]
    private enum CodingKeys: String, CodingKey {
        case actors = "cast"
    }
}
struct ActorDetails: Decodable {
    let actorName: String?
    let actorCharacter: String?
    let actorImage: String?
    let actorId: Int?
    private enum CodingKeys: String, CodingKey {
        case actorName = "name"
        case actorCharacter = "character"
        case actorImage = "profile_path"
        case actorId = "id"
    }
}
