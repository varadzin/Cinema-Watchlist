//
//  MovieTableViewCell.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 11/04/2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    var moviePoster = UIImageView()
    var movieTitle = UILabel()
    var movieYear = UILabel()
    var movieOverview = UILabel()
    var movieId = UILabel()
    private var urlString = ""
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configMovieImg()
        configMovieTitle()
        configMovieDate()
        configMovieDescr()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setCellWithValuesOf(_ movie: MovieDetails) {
        updateUI(title: movie.title, releaseDate: movie.year, overview: movie.overview, poster: movie.posterImage, id: movie.id)
    }
    // Update UI Views
    private func updateUI(title: String?, releaseDate: String?, overview: String?, poster: String?, id: Int?) {
        self.movieTitle.text = title
        self.movieYear.text = convertDateFormater(releaseDate)
        self.movieOverview.text = overview
        self.movieId.text = "\(String(describing: id))"
        guard let posterString = poster else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        guard let posterImageURL = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        // Before downloading the image, clear out the old one
        self.moviePoster.image = nil
        getImageDataFrom(url: posterImageURL)
    }
    // MARK: Get image data
    func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error ) in
            // Handle error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            guard let data = data else {
                // Handle empty data
                print("Empty data")
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.moviePoster.image = image
                }
            }
        }.resume()
    }
    // MARK: - Convert date format
    func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
}
