//
//  NetworkManager.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 11/04/2021.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private var dataTask: URLSessionDataTask?
    let cache = NSCache<NSString, UIImage>()
    let myApiKey = ApiKey().APIKEY
    // MARK: - API is used by fetching Movies for selected Actor
    func getSearchedMoviesData(chosedMovie: Int, completed: @escaping(Result<ActorDetailsModel, PossibleErrors>) -> Void) {
        let apiURL1 = "https://api.themoviedb.org/3/movie/"
        let apiURL2 = "/credits"
        let apiURL3 = "&language=en-US"
        let searchedMoviesURL = apiURL1 + "\(chosedMovie)" + apiURL2 + myApiKey + apiURL3
        guard let url = URL(string: searchedMoviesURL) else {
            completed(.failure(.invalidRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completed(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let followers = try decoder.decode(ActorDetailsModel.self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    // MARK: - API is used by fetching Actor Images
    func getActorImages(chosedActor: Int, completed: @escaping(Result<ActorImagesModel, PossibleErrors>) -> Void) {
        let apiURL1 = "https://api.themoviedb.org/3/person/"
        let apiURL2 = "/images"
        let actorImagesURL = apiURL1 + "\(chosedActor)" + apiURL2 + myApiKey
        guard let url = URL(string: actorImagesURL) else {
            completed(.failure(.invalidRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completed(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let actorImages = try decoder.decode(ActorImagesModel.self, from: data)
                completed(.success(actorImages))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    // MARK: - API is used by fetching Movie Images in MovieInfoVC
    func getMovieImages(chosedMovie: Int, completed: @escaping(Result<MovieImagesModel, PossibleErrors>) -> Void) {
        let apiURL1 = "https://api.themoviedb.org/3/movie/"
        let apiURL2 = "/images"
        let actorImagesURL = apiURL1 + "\(chosedMovie)" + apiURL2 + myApiKey
        guard let url = URL(string: actorImagesURL) else {
            completed(.failure(.invalidRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completed(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let actorImages = try decoder.decode(MovieImagesModel.self, from: data)
                completed(.success(actorImages))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    // MARK: - API is used by fetching Actor Filmography
    func getActorMoviesData(actorId: Int, completed: @escaping(Result<ActorMoviesDetailsModel, PossibleErrors>) -> Void) {
        let apiURL1 = "https://api.themoviedb.org/3/person/"
        let apiURL2 = "/movie_credits"
        let apiURL3 = "&language=en-US"
        let searchedMoviesURL = apiURL1 + "\(actorId)" + apiURL2 + myApiKey + apiURL3
        guard let url = URL(string: searchedMoviesURL) else {
            completed(.failure(.invalidRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completed(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let actorMovies = try decoder.decode(ActorMoviesDetailsModel.self, from: data)
                completed(.success(actorMovies))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    // MARK: - API is used by fetching trendig Movies for first screen
    func getTrending(completed: @escaping(Result<MovieDetailsModel, PossibleErrors>) -> Void) {
        let apiURL1 = "https://api.themoviedb.org/3/movie/popular"
        let apiURL2 = "&language=en-US"
        let searchedMoviesURL = apiURL1 + myApiKey + apiURL2
        guard let url = URL(string: searchedMoviesURL) else {
            completed(.failure(.invalidRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completed(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode(MovieDetailsModel.self, from: data)
                completed(.success(movies))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    // MARK: - API is used by fetching searches Movie for first screen
    func getSearchedMoviesData(lookingForMovie: String, completition: @escaping (Result<MovieDetailsModel, PossibleErrors>) -> Void) {
        let apiURL1 = "https://api.themoviedb.org/3/search/movie"
        let apiURL2 = "&language=en-US&page=1&include_adult=false"
        let searchedMoviesURL = apiURL1 + myApiKey + apiURL2 + "&query=\(lookingForMovie)"
        guard let url = URL(string: searchedMoviesURL) else {return}
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle error
            if let error = error {
                completition(.failure(.invalidRequest))
                print("DataTask error \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \( response.statusCode)")
            guard let data = data else {
                // Handle empty data
                print("Empty Data")
                return
            }
            do {
                // parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieDetailsModel.self, from: data)
                DispatchQueue.main.async {
                    completition(.success(jsonData))
                }
            } catch {
                completition(.failure(.invalidData))
            }
        }
        dataTask?.resume()
    }
}
