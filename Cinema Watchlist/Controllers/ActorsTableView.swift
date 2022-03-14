//
//  ActorsTableView.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 27/03/2021.
//

import UIKit
class ActorsTableView: UITableViewController {
    var movieId = Int()
    var movieName = String()
    let cache = NetworkManager.shared.cache
    private var apiService = NetworkManager()
    private var searchedActors = [ActorDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        getMoviesData()
        title = movieName
    }
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ActorsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 155
        tableView.frame = view.bounds
    }
    // MARK: - Tableview with Actors who play in Movie
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedActors.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ActorsTableViewCell
        cell.accessoryType = .disclosureIndicator
        let actors = searchedActors[indexPath.row]
        cell.actorsNameLbl.text = actors.actorName!
        cell.actorsCharacterLbl.text = "Character: \n\(actors.actorCharacter!)"
        if actors.actorImage != nil {
            let urlStringActorPoster = "https://image.tmdb.org/t/p/w300" + actors.actorImage!
            let url = URL(string: urlStringActorPoster)
            cell.actorPoster.load(url: url!)
        } else {
            cell.actorPoster.image = UIImage(named: "moviePlaceholder")
        }
        return cell
    }
    // MARK: - show ActorInfoVC and transfer ActorID, ActorImage, ActorName
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actors = searchedActors[indexPath.row]
        let destVC = ActorInfoViewController()
        destVC.actorIdentity = actors.actorId!
        if actors.actorImage == nil {
            uniAlertVC(title: "Upps, my appologies!", message: "I have no more Data about \(actors.actorName!)", buttonTitle: "OK")
        } else {
            destVC.actorImage = "https://image.tmdb.org/t/p/w300" + actors.actorImage!
            destVC.actorName = actors.actorName!
            navigationController?.pushViewController(destVC, animated: true)
        }
    }
    // MARK: - get Data about the Movie
    func getMoviesData() {
        NetworkManager.shared.getSearchedMoviesData(chosedMovie: Int(movieId)) { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.searchedActors = listOf.actors
            case .failure(let error):
                print("Error procesing data \(error)")
            }
        }
    }
}
