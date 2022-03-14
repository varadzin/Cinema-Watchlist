//
//  ActorInfoViewController.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 02/03/2021.
//
import UIKit
class ActorInfoViewController: UIViewController, ActorManagerDelegate, UIScrollViewDelegate {
    let tableView = UITableView()
    let scrollView = UIScrollView()
    private var actorImages = [ActorImages]()
    var actorMoviesArray = [ActorMoviesDetails]()
    private var apiService = NetworkManager()
    var actorIdentity = Int()
    var urlStringActor = ""
    let cache = NetworkManager.shared.cache
    var actorPoster = UIImageView()
    var shadow = UIImageView()
    var actorImage = String()
    var biographyLbl = UITextView()
    var actorName = String()
    var favButton = UIButton()
    var filmographyButton = UIButton()
    var favActorId = [Int]()
    var favActorPoster = [String]()
    var favActorName = [String]()
    var collectionView: UICollectionView!
    let defaults = UserDefaults.standard
    var actorManager = ActorManager()
    var imagesBtn = UIButton()
    var urlString = ""
    var sampleImage = UIImageView()
    var actorAllMoviesArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        actorManager.delegate = self
        fetchActorData()
        getNextScreenImgFilmography()
        configViewController()
        loadActorArrays()
        configScrollView()
        configShadow()
        configActorPoster()
        configFavBtn()
        configActorBio()
        showActorPoster()
        configFilmBtn()
        configImagesBtn()
        nextVCImages()
    }
    // MARK: - get Images for next screen - Filmography and caching it
    func getNextScreenImgFilmography() {
        let actorIdent = actorIdentity
        NetworkManager.shared.getActorMoviesData(actorId: actorIdent) { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.actorMoviesArray = listOf.actorMovies
            case .failure(let error):
                print("Error porcesing data \(error)")
            }
        }
    }
    func nextVCImages() {
        let actorId = actorIdentity
        NetworkManager.shared.getActorImages(chosedActor: actorId) { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.actorImages = listOf.images
            case .failure(let error):
                print("Error getActorImages() \(error)")
            }
        }
    }
    // MARK: - get Data about Actor
    func fetchActorData() {
        actorManager.fetchActor(searchedActorId: actorIdentity)
    }
    // MARK: - remove Actor from Favorites Array
    func removeFromFavorites() {
        if let index = favActorId.firstIndex(of: actorIdentity) {
            favActorId.remove(at: index)
        }
        if let index = favActorName.firstIndex(of: actorName) {
            favActorName.remove(at: index)
        }
        if let index = favActorPoster.firstIndex(of: urlStringActor) {
            favActorPoster.remove(at: index)
        }
        defaults.set(favActorId, forKey: "SavedActorID")
        defaults.set(favActorPoster, forKey: "SavedActorPoster")
        defaults.set(favActorName, forKey: "SavedActorName")
        configFavBtn()
    }
    func loadActorArrays() {
        if defaults.array(forKey: "SavedActorID") == nil { return } else {
            favActorId = defaults.array(forKey: "SavedActorID") as! [Int]
            favActorName = defaults.object(forKey: "SavedActorName") as! [String]
            favActorPoster = defaults.object(forKey: "SavedActorPoster") as! [String]
        }
    }
    // MARK: - add Actor to Favorites
    @objc func favButtonTapped() {
        if favActorId.contains(actorIdentity) { removeFromFavorites() } else {
            if urlStringActor == "" { return } else {
                favActorId.append(actorIdentity)
                favActorPoster.append(urlStringActor)
                favActorName.append(actorName)
                defaults.set(favActorId, forKey: "SavedActorID")
                defaults.set(favActorPoster, forKey: "SavedActorPoster")
                defaults.set(favActorName, forKey: "SavedActorName")
                configFavBtn()
            }
        }
    }
    func showActorPoster() {
        urlStringActor = actorImage
        let url = URL(string: urlStringActor)
        actorPoster.load(url: url!)
    }
    // MARK: - show Filmography VC and transfer ActorName + ActorId
    @objc func filmBtnTapped() {
        let destVC = ActorMoviesTableView()
        destVC.title = actorName
        destVC.actorIdent = actorIdentity
        navigationController?.pushViewController(destVC, animated: true)
    }
}
// MARK: - get Data about Actor
extension ActorInfoViewController {
    func didUpdateActor(_ actorManager: ActorManager, actor: ActorMoreDetailsModel) {
        DispatchQueue.main.async {
            if actor.actorBiography == "" {
                self.biographyLbl.text = "I'm sorry. I've tried hard, but for \(self.actorName) is no biography available. But enjoy the Picture."
            } else {
                self.biographyLbl.text = actor.actorBiography }
            self.configActorBio()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
