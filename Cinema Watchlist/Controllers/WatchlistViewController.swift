//
//  WatchlistViewController.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 08/02/2021.
//

import UIKit

class WatchlistViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var collectionView: UICollectionView?
    var movieIdArray = [Int]()
    var movieNameArray = [String]()
    var moviePosterArray = [String]()
    let defaults = UserDefaults.standard
    let textLabel = UILabel()
    var collViewIsHidden = true
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        savedInArrays()
        configCollectionView()
        configAboutBtn()
    }
    override func viewWillAppear(_ animated: Bool) {
        savedInArrays()
        configCollectionView()
    }
    // info Button up right in navigationBar
    func configAboutBtn() {
        let aboutBtn = UIBarButtonItem(title: "App info", style: .done, target: self, action: #selector(aboutApp))
        navigationItem.rightBarButtonItem = aboutBtn
    }
    @objc func aboutApp() {
        let destVC = AboutViewController()
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    // MARK: - get Favorites Actors, saved in NSUser.defaults
    func savedInArrays() {
        // if is watchlist empty hides collection view and shows the message
        if defaults.array(forKey: "SavedMovieID") == nil {
            emptyScreenLabel()
        } else {
            movieIdArray =  defaults.array(forKey: "SavedMovieID") as! [Int]
            movieNameArray = defaults.array(forKey: "SavedMovieName") as! [String]
            moviePosterArray = defaults.array(forKey: "SavedMoviePoster") as! [String]
            collViewIsHidden = false
        }
    }
    func emptyScreenLabel() {
        textLabel.textColor = .systemGray2
        textLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.text = "Your Watchlist is empty, tap ⭐️ to add a Movie"
        view.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textLabel.heightAnchor.constraint(equalToConstant: 100),
            textLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    // MARK: - Collection View in whole Screen
    func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: 170, height: 270)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        // here hides collection view if is watchlist empty
        if collViewIsHidden == true {
            collectionView.isHidden = true
        } else {
            view.addSubview(collectionView)
            collectionView.frame = view.bounds
            collectionView.backgroundColor = .systemBackground
            collectionView.register(FavoriteMoviesCell.self, forCellWithReuseIdentifier: FavoriteMoviesCell.reuseID)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieIdArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteMoviesCell.reuseID, for: indexPath) as! FavoriteMoviesCell
        let urlString = moviePosterArray[indexPath.row]
        let url = URL(string: urlString)
        cell.favoritesPoster.load(url: url!)
        cell.favoritesMovieLbl.text = movieNameArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = MovieInfoViewController()
        destVC.movieTitleValue = movieNameArray[indexPath.row]
        destVC.moviePosterValue = moviePosterArray[indexPath.row]
        destVC.movieIdValue = movieIdArray[indexPath.row]
        navigationController?.pushViewController(destVC, animated: true)
    }
    func configViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
