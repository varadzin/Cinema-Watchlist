//
//  FavoritesViewController.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 08/02/2021.
//

import UIKit
class FavoritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var collectionView: UICollectionView!
    var actorIdArray = [Int]()
    var actorNameArray = [String]()
    var actorPosterArray = [String]()
    let defaults = UserDefaults.standard
    let textLabel = UILabel()
    var collViewIsHidden = true
    var urlString = String()
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
        // if is favorites list empty hides collection view and shows the message
        if defaults.array(forKey: "SavedActorID") == nil {
            emptyScreenLabel()
        } else {
            actorIdArray = defaults.array(forKey: "SavedActorID") as! [Int]
            actorNameArray = defaults.array(forKey: "SavedActorName") as! [String]
            actorPosterArray = defaults.array(forKey: "SavedActorPoster") as! [String]
            collViewIsHidden = false
        }
    }
    func emptyScreenLabel() {
        textLabel.textColor = .systemGray2
        textLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.text = "Your List is empty, tap ❤️ to add an Actor"
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
        layout.itemSize = CGSize(width: 170, height: 280)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        if collViewIsHidden == true {
            collectionView.isHidden = true
        } else {
            view.addSubview(collectionView)
            collectionView.frame = view.bounds
            collectionView.backgroundColor = .systemBackground
            collectionView.register(FavoriteMoviesCell.self, forCellWithReuseIdentifier: FavoriteMoviesCell.reuseID)
            collectionView.delegate = self
            collectionView.dataSource = self
        }}
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actorIdArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteMoviesCell.reuseID, for: indexPath) as! FavoriteMoviesCell
        urlString = actorPosterArray[indexPath.row]
        let url = URL(string: urlString)
        cell.favoritesPoster.load(url: url!)
        cell.favoritesMovieLbl.text = actorNameArray[indexPath.row]
        return cell
    }
    // MARK: - tap on selected Actor shows ActorInfoVC and transfer ActorID, ActorName, ActorImage
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = ActorDetailsViewContoller()
        destVC.actorIdentity = actorIdArray[indexPath.row]
        destVC.actorName = actorNameArray[indexPath.row]
        destVC.actorImage = actorPosterArray[indexPath.row]
        navigationController?.pushViewController(destVC, animated: true)
    }
    func configViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        }
}
