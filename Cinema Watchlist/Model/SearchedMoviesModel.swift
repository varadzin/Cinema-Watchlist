//
//  SearchedMoviesModel.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 11/04/2021.
//  This model is used by searching movies on first screen for TableView

import UIKit

class SearchedMoviesModel {
    private var apiService = NetworkManager()
    private var searchedMovies = [MovieDetails]()
    func fetchSearchedMoviesData(lookingForMovie: String, completition: @escaping() -> Void) {
        apiService.getSearchedMoviesData(lookingForMovie: lookingForMovie) { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.searchedMovies = listOf.movies
                completition()
            case .failure(let error):
                print("Error procesing data \(error)")
            }
        }
    }
    func numberOfRowsInSection (section: Int) -> Int {
        if searchedMovies.count != 0 {
            return searchedMovies.count
        }
        return 0
    }
    func cellForRowAt (indexPath: IndexPath) -> MovieDetails {
        return searchedMovies[indexPath.row]
    }
}
