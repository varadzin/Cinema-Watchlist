//
//  MovieInfoViewController.swift
// Watchlist
//
//  Created by Frantisek Varadzin on 11/04/2021.
//

import UIKit

class MovieInfoViewController: UIViewController, MovieManagerDelegate {
    private var apiService = NetworkManager()
    private var searchedMovies = [MovieDetails]()
    private var searchedActors = [ActorDetails]()
    private var movieImages = [MovieImages]()
    let scrollView = UIScrollView()
    var collectionView: UICollectionView!
    let moviePoster = UIImageView()
    var shadow = UIImageView()
    var movieTitleValue = String()
    var moviePosterValue = String()
    var movieIdValue = Int()
    let defaults = UserDefaults.standard
    var movieIdArray = [Int]()
    var movieNameArray = [String]()
    var moviePosterArray = [String]()
    var movieOverview = UILabel()
    var movieOverviewValue = String()
    var movieManager = MovieManager()
    var actorsBtn = UIButton()
    var watchlistBtn = UIButton()
    var movieBudgetLbl = UILabel()
    var movieBudgetValue = Int()
    var movieRevenueLbl = UILabel()
    var movieRevenueValue = Int()
    var movieReleaseLbl = UILabel()
    var movieReleaseValue = String()
    var movieRuntimeLbl = UILabel()
    var movieRuntimeValue = Int()
    var movieLanguageLbl = UILabel()
    var movieLanguageValue = String()
    var movieProfitLbl = UILabel()
    var movieProfitVaule = Int()
    var movieSecondPic = UIImageView()
    var movieSecPicValue: String?
    var opacityLayer = UIImageView()
    var moviePicBtn = UIButton()
    var moviePicBtn2 = UIButton()
    var titleLabel = UILabel()
    var movieBudgetAvaiable = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        movieManager.delegate = self
        configViewController()
        configScrollView()
        configShadow()
        loadMoviesArrays()
        fetchMoviesData()
        configMoviePoster()
        configActorsBtn()
        configWatchlistBtn()
        getNextScreenImgActors()
        getNextScreenImgMovies()
        configMoviePicBtn2()
    }
    // MARK: - get Images for next screen - Images of the Movie and cache them
    func getNextScreenImgMovies() {
        let movieId = movieIdValue
        NetworkManager.shared.getMovieImages(chosedMovie: movieId) { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.movieImages = listOf.images
            case .failure(let error):
                print("Error getActorImages() \(error)")
            }
        }
    }
    // MARK: - get Images for next screen - Actors Images and cache them
    func getNextScreenImgActors() {
        let movieId = movieIdValue
        NetworkManager.shared.getSearchedMoviesData(chosedMovie: Int(movieId)) { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.searchedActors = listOf.actors
            case .failure(let error):
                print("Error procesing data \(error)")
            }
        }
    }
    func fetchMoviesData() {
        movieManager.fetchMovie(searchedMovieId: movieIdValue)
    }
    func showMoviePoster() {
        let urlStringMovie = "https://image.tmdb.org/t/p/w300" + moviePosterValue
        let url = URL(string: urlStringMovie)
        moviePoster.load(url: url!)
    }
    func removeFromFavorites() {
        if let index = movieIdArray.firstIndex(of: movieIdValue) {
            movieIdArray.remove(at: index)
        }
        if let index = movieNameArray.firstIndex(of: movieTitleValue) {
            movieNameArray.remove(at: index)
        }
        if let index = moviePosterArray.firstIndex(of: "https://image.tmdb.org/t/p/w300" + moviePosterValue) {
            moviePosterArray.remove(at: index)
        }
        defaults.set(movieIdArray, forKey: "SavedMovieID")
        defaults.set(movieNameArray, forKey: "SavedMovieName")
        defaults.set(moviePosterArray, forKey: "SavedMoviePoster")
        configWatchlistBtn()
    }
    @objc func watchlistTapped() {
        if movieIdArray.contains(movieIdValue) {
            removeFromFavorites()
        } else {
            if moviePosterValue == "" { return } else {
                movieIdArray.append(movieIdValue)
                moviePosterArray.append("https://image.tmdb.org/t/p/w300" + moviePosterValue)
                movieNameArray.append(movieTitleValue)
                defaults.set(movieIdArray, forKey: "SavedMovieID")
                defaults.set(movieNameArray, forKey: "SavedMovieName")
                defaults.set(moviePosterArray, forKey: "SavedMoviePoster")
                configWatchlistBtn()
            }
        }
    }
    func loadMoviesArrays() {
        if defaults.array(forKey: "SavedMovieID") == nil { return } else {
            movieIdArray = defaults.array(forKey: "SavedMovieID") as! [Int]
            movieNameArray = defaults.object(forKey: "SavedMovieName") as! [String]
            moviePosterArray = defaults.object(forKey: "SavedMoviePoster") as! [String]
        }
    }
    func showMovieSecPic() {
        if movieSecPicValue != nil {
            let urlStringMovie = "https://image.tmdb.org/t/p/w300" + movieSecPicValue!
            let url = URL(string: urlStringMovie)
            movieSecondPic.load(url: url!)
        } else { return }
    }
}
extension MovieInfoViewController {
    func didUpdateMovie(_ movieManager: MovieManager, movie: MovieMoreDetailsModel) {
        DispatchQueue.main.async {
            self.moviePosterValue = movie.moviePicture
            self.showMoviePoster()
            self.configMoviePoster()
            self.movieOverviewValue = movie.movieOverview
            self.configOverview()
            self.movieSecPicValue = movie.movieSecPic
            self.showMovieSecPic()
            self.configMovieSecPic()
            self.configOpacityLayer()
            self.movieBudgetValue = movie.movieBudget
            self.configMovieBudget()
            self.movieRevenueValue = movie.movieRevenue
            self.configMovieRevenue()
            self.configMovieProfit()
            self.movieReleaseValue = movie.movieRelease
            self.configMovieRelease()
            self.movieRuntimeValue = movie.movieRuntime
            self.configMovieRuntime()
            self.movieLanguageValue = movie.movieLanguage
            self.configMovieLanguage()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
