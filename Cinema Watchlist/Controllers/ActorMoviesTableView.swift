//
//  ActorMoviesTableView.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 23/03/2021.
//

import UIKit
class ActorMoviesTableView: UITableViewController {
    let cache = NetworkManager.shared.cache
    let myApiKey = ApiKey().APIKEY
    var actorMoviesArray = [ActorMoviesDetails]()
    var actorIdent = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        getData()
    }
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ActorMoviesCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight = 155
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actorMoviesArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ActorMoviesCell
        let actorMoviesData = actorMoviesArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.actorMovieYearLbl.text = actorMoviesData.year
        cell.actorMovieTitleLbl.text = actorMoviesData.title
        cell.actorMovieTextLbl.text = actorMoviesData.overview
        if actorMoviesData.posterImage != nil {
            let urlStringMoviePoster = "https://image.tmdb.org/t/p/w300" + actorMoviesData.posterImage!
            let url = URL(string: urlStringMoviePoster)
            cell.actorMoviePoster.load(url: url!)
        } else {
            cell.actorMoviePoster.image = UIImage(named: "moviePlaceholder")
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actorMoviesData = actorMoviesArray[indexPath.row]
        let destVC = MovieInfoViewController()
        if actorMoviesData.posterImage == nil {
            uniAlertVC(title: "Upps, my appologies!", message: "I have no more Data about \(actorMoviesData.title!) movie", buttonTitle: "OK")
        } else {
            destVC.movieIdValue = actorMoviesData.id!
            destVC.movieTitleValue = actorMoviesData.title!
            navigationController?.pushViewController(destVC, animated: true)
        }
    }
    func getData() {
        NetworkManager.shared.getActorMoviesData(actorId: actorIdent) { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.actorMoviesArray = listOf.actorMovies
            case .failure(let error):
                print("Error porcesing data \(error)")
            }
        }
    }
}
