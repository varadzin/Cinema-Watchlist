//
//  MovieManager.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 15/03/2021.
//

import UIKit

protocol MovieManagerDelegate {
    func didUpdateMovie(_ movieManager: MovieManager, movie: MovieMoreDetailsModel)
    func didFailWithError(error: Error)
}
class MovieManager {
    let myApiKey = ApiKey().APIKEY
    var delegate: MovieManagerDelegate?
    func fetchMovie(searchedMovieId: Int) {
        let apiURL1 = "https://api.themoviedb.org/3/movie/"
        let apiURL2 = "\(searchedMovieId)"
        let apiURL3 = "&language=en-US"
        let movieURL = apiURL1 + apiURL2 + myApiKey + apiURL3
        performRequest(with: movieURL)
    }
    func performRequest(with movieURL: String) {
        if let url = URL(string: movieURL) {
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
                    if let myMovie = self.parseJSON(safeData) {
                        self.delegate?.didUpdateMovie(self, movie: myMovie)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ movieData: Data) -> MovieMoreDetailsModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieMoreDetails2.self, from: movieData)
            let overview = decodedData.overview
            let budget = decodedData.budget
            let picture = decodedData.poster_path
            let revenue = decodedData.revenue
            let runtime = decodedData.runtime
            let language = decodedData.original_language
            let release = decodedData.release_date
            let secPic = decodedData.backdrop_path
            let movieInfo = MovieMoreDetailsModel(movieOverview: overview, movieBudget: budget, moviePicture: picture, movieRevenue: revenue, movieRelease: release, movieRuntime: runtime, movieLanguage: language, movieSecPic: secPic)
            return movieInfo
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
