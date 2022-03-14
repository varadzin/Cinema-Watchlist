//
//  MovieImagesCollectionVC.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 28/03/2021.
//

import UIKit

class MovieImagesCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private let reuseIdentifier = "Cell"
    var movieId = Int()
    var collectionView: UICollectionView?
    private var movieImages = [MovieImages]()
    private var apiService = NetworkManager()
    let cache = NetworkManager.shared.cache
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieImages()
        configCollectionView()
        configDoneBtn()
    }
    func configDoneBtn() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 350, height: 200)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(MovieImagesCell.self, forCellWithReuseIdentifier: MovieImagesCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .systemBackground
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieImagesCell.reuseID, for: indexPath) as! MovieImagesCell
        let moviePicture = movieImages[indexPath.row]
        if moviePicture.movieImage != nil {
            let urlStringActor = "https://image.tmdb.org/t/p/w300" + moviePicture.movieImage!
            let url = URL(string: urlStringActor)
            cell.movieImage.load(url: url!)
        } else {
            cell.movieImage.image = UIImage(named: "moviePlaceholder")
        }
        return cell
    }
    func getMovieImages() {
        NetworkManager.shared.getMovieImages(chosedMovie: movieId) { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.movieImages = listOf.images
            case .failure(let error):
                print("Error getActorImages() \(error)")
            }
        }
        }
}
