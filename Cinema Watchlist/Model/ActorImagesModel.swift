//
//  ActorImagesModel.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 28/03/2021.
//

import Foundation

struct ActorImagesModel: Decodable {
    let images: [ActorImages]
    private enum CodingKeys: String, CodingKey {
        case images = "profiles"
    }
}
struct ActorImages: Decodable {
    let actorImage: String?
    private enum CodingKeys: String, CodingKey {
        case actorImage = "file_path"
    }
}
