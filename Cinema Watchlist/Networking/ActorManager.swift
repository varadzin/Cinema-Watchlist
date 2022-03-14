//
//  ActorManager.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 16/03/2021.
//

import UIKit

protocol ActorManagerDelegate {
    func didUpdateActor(_ actorManager: ActorManager, actor: ActorMoreDetailsModel)
    func didFailWithError(error: Error)
}
class ActorManager {
    let myApiKey = ApiKey().APIKEY
    var delegate: ActorManagerDelegate?
    func fetchActor(searchedActorId: Int) {
        let apiURL1 = "https://api.themoviedb.org/3/person/"
        let apiURL2 = "\(searchedActorId)"
        let apiURL3 = "&language=en-US"
        let actorURL = apiURL1 + apiURL2 + myApiKey + apiURL3
        performRequest(with: actorURL)
    }
    func performRequest(with actorURL: String) {
        if let url = URL(string: actorURL) {
            let session =  URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return
                }
                if let safeData = data {
                    if let myActor = self.parseJSON(safeData) {
                        self.delegate?.didUpdateActor(self, actor: myActor)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ actorData: Data) -> ActorMoreDetailsModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ActorDetails2.self, from: actorData)
            let actorName = decodedData.name
            let actorBiography = decodedData.biography
            let actorPoster = decodedData.profile_path
            let actorInfo = ActorMoreDetailsModel(actorName: actorName, actorBiography: actorBiography, actorPoster: actorPoster)
            return actorInfo
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
