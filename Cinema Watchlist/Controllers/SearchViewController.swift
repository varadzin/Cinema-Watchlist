//
//  SearchViewController.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 11/04/2021.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    var collectionView: UICollectionView?
    let searchBar = UISearchBar()
    let tableView = UITableView()
    var viewModel = SearchedMoviesModel()
    var titleNowPlaying = UILabel()
    var trendingMovies = [MovieDetails]()
    var trendingMovieImage = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        getTrendingMovies()
        configView()
        configSearchBar()
        configTableView()
        hideTableView()
        configTitle()
        configCollectionView()
        collectionView?.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    // MARK: - hide / unhide TableView / Trending Movies - after searching Movie
    func hideTableView() {
        tableView.isHidden = true
        collectionView?.isHidden = false
        titleNowPlaying.isHidden = false
    }
    func unhideTableView() {
        tableView.isHidden = false
        collectionView?.isHidden = true
        titleNowPlaying.isHidden = true
    }
    func configTitle() {
        view.addSubview(titleNowPlaying)
        titleNowPlaying.text = "Trending"
        titleNowPlaying.textColor = .label
        titleNowPlaying.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleNowPlaying.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleNowPlaying.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            titleNowPlaying.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleNowPlaying.widthAnchor.constraint(equalToConstant: 200),
            titleNowPlaying.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    // MARK: - CollectionView - Trending Movies
    func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 170, height: 280)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(TrendingMoviesCell.self, forCellWithReuseIdentifier: TrendingMoviesCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.keyboardDismissMode = .onDrag
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleNowPlaying.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        ])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingMovies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingMoviesCell.reuseID, for: indexPath) as! TrendingMoviesCell
        let trendingMovie = trendingMovies[indexPath.row]
        if trendingMovie.posterImage != nil {
            let urlString = "https://image.tmdb.org/t/p/w300" + trendingMovie.posterImage!
            let url = URL(string: urlString)
            cell.favoritesPoster.load(url: url!)
        } else {
            cell.favoritesPoster.image = UIImage(named: "moviePlaceholder")
        }
        cell.favoritesMovieLbl.text = trendingMovie.title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = MovieInfoViewController()
        destVC.movieTitleValue = trendingMovies[indexPath.row].title!
        destVC.movieIdValue = trendingMovies[indexPath.row].id!
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    // MARK: - Search function
    func loadSearchedMoviesData(lookingForMovie: String?) {
        if lookingForMovie != "" {
            viewModel.fetchSearchedMoviesData(lookingForMovie: lookingForMovie!) { [weak self] in
                self?.tableView.reloadData()}
        }
    }
    func configView() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    func configSearchBar() {
        view.addSubview(searchBar)
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search a movie"
        searchBar.autocorrectionType = .no
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { unhideTableView() }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) { hideTableView()}
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadSearchedMoviesData(lookingForMovie: searchText)
    }
    // MARK: - Search result  - TableView
    func configTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 155
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .onDrag
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    // MARK: - Get Data Function from JSON
    func getTrendingMovies() {
        NetworkManager.shared.getTrending { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.trendingMovies = listOf.movies
            case .failure(let error):
                print("Error getActorImages() \(error)")
            }
        }
    }
}
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        cell.accessoryType = .disclosureIndicator // small arrow on the right
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        let destVC = MovieInfoViewController()
        destVC.movieTitleValue = movie.title!
        destVC.movieOverviewValue = movie.overview!
        destVC.movieIdValue = Int(movie.id!)
        if movie.year != nil {
            destVC.movieReleaseValue = movie.year!
        } else { destVC.movieReleaseValue = ""}
        if movie.posterImage != nil {
            destVC.moviePosterValue = movie.posterImage! } else {
                destVC.moviePosterValue = "noImageAvailable"
            }
        navigationController?.pushViewController(destVC, animated: true)
    }
}
