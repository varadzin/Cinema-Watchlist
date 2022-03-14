//
//  ActorImagesCollectionVC.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 28/03/2021.
//

import UIKit
private let reuseIdentifier = "Cell"
class ActorImagesCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var actorId = Int()
    var collectionView: UICollectionView?
    private var actorImages = [ActorImages]()
    private var apiService = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        getActorImages()
        configCollectionView()
        configDoneBtn()
        collectionView?.reloadData()
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
        layout.itemSize = CGSize(width: 180, height: 225)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(ActorImagesCollectionViewCell.self, forCellWithReuseIdentifier: ActorImagesCollectionViewCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .systemBackground
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actorImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorImagesCollectionViewCell.reuseID, for: indexPath) as! ActorImagesCollectionViewCell
        let actorPicture = actorImages[indexPath.row]
        let urlStringActor = "https://image.tmdb.org/t/p/w300" + actorPicture.actorImage!
        if actorPicture.actorImage != nil {
            let url = URL(string: urlStringActor)
            cell.actorImagePoster.load(url: url!)
        } else {
            cell.actorImagePoster.image = UIImage(named: "moviePlaceholder")
        }
        return cell
    }
    func getActorImages() {
        NetworkManager.shared.getActorImages(chosedActor: actorId) { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.actorImages = listOf.images
            case .failure(let error):
                print("Error getActorImages() \(error)")
            }
        }
        }
}
