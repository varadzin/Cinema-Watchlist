//
//  MovieInfoViewController+Ext.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 21/05/2021.
//

import UIKit

extension MovieInfoViewController {
    func configMoviePicBtn2() {
        scrollView.addSubview(moviePicBtn2)
        moviePicBtn2.addTarget(self, action: #selector(moviePicBtnTapped), for: .touchUpInside)
        moviePicBtn2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moviePicBtn2.topAnchor.constraint(equalTo: scrollView.topAnchor),
            moviePicBtn2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            moviePicBtn2.widthAnchor.constraint(equalToConstant: 160),
            moviePicBtn2.heightAnchor.constraint(equalToConstant: 230)
        ])
    }
    @objc func moviePicBtnTapped() {
        let destVC = MovieImagesCollectionVC()
        destVC.movieId = movieIdValue
        destVC.title = movieTitleValue
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    func configOpacityLayer() {
        scrollView.addSubview(opacityLayer)
        opacityLayer.image = UIImage(named: "opacityLayer")
        opacityLayer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            opacityLayer.topAnchor.constraint(equalTo: movieOverview.bottomAnchor, constant: 15),
            opacityLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            opacityLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            opacityLayer.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    func configMovieSecPic() {
        scrollView.addSubview(movieSecondPic)
        movieSecondPic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieSecondPic.topAnchor.constraint(equalTo: movieOverview.bottomAnchor, constant: 20),
            movieSecondPic.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieSecondPic.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieSecondPic.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    func configMovieLanguage() {
        scrollView.addSubview(movieLanguageLbl)
        movieLanguageLbl.textColor = .label
        movieLanguageLbl.numberOfLines = 0
        movieLanguageLbl.text = "Language: \(movieLanguageValue)"
        movieLanguageLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        movieLanguageLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieLanguageLbl.topAnchor.constraint(equalTo: movieRuntimeLbl.bottomAnchor, constant: 10),
            movieLanguageLbl.leadingAnchor.constraint(equalTo: movieBudgetLbl.trailingAnchor, constant: 45),
            movieLanguageLbl.widthAnchor.constraint(equalToConstant: 150),
            movieLanguageLbl.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    func configMovieRelease() {
        scrollView.addSubview(movieReleaseLbl)
        movieReleaseLbl.textColor = .label
        movieReleaseLbl.numberOfLines = 0
        movieReleaseLbl.text = "Release: \(movieReleaseValue)"
        movieReleaseLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        movieReleaseLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieReleaseLbl.topAnchor.constraint(equalTo: movieSecondPic.topAnchor, constant: 35),
            movieReleaseLbl.leadingAnchor.constraint(equalTo: movieBudgetLbl.trailingAnchor, constant: 45),
            movieReleaseLbl.widthAnchor.constraint(equalToConstant: 150),
            movieReleaseLbl.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    func configMovieRuntime() {
        scrollView.addSubview(movieRuntimeLbl)
        movieRuntimeLbl.textColor = .label
        movieRuntimeLbl.numberOfLines = 0
        movieRuntimeLbl.text = "Runtime: \(movieRuntimeValue) min"
        movieRuntimeLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        movieRuntimeLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieRuntimeLbl.topAnchor.constraint(equalTo: movieReleaseLbl.bottomAnchor, constant: 10),
            movieRuntimeLbl.leadingAnchor.constraint(equalTo: movieBudgetLbl.trailingAnchor, constant: 45),
            movieRuntimeLbl.widthAnchor.constraint(equalToConstant: 150),
            movieRuntimeLbl.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    func configMovieProfit() {
        scrollView.addSubview(movieProfitLbl)
        movieProfitLbl.textColor = .label
        movieProfitLbl.textAlignment = .right
        movieProfitLbl.adjustsFontSizeToFitWidth = true
        // if revenue or budget is not avaiable
        if movieRevenueValue == 0 || movieBudgetAvaiable == false {
            movieProfitLbl.text = "Profit is not avaiable"
        } else {
            // Number Formatter
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 0
            let profitValue = movieRevenueValue - movieBudgetValue
            let formattedValue = formatter.string(from: NSNumber(value: profitValue))!
            movieProfitLbl.text = "Profit: \(formattedValue)"
        }
        movieProfitLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        movieProfitLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieProfitLbl.topAnchor.constraint(equalTo: movieRevenueLbl.bottomAnchor, constant: 10),
            movieProfitLbl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 5),
            movieProfitLbl.widthAnchor.constraint(equalToConstant: 150),
            movieProfitLbl.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    func configMovieBudget() {
        scrollView.addSubview(movieBudgetLbl)
        movieBudgetLbl.textColor = .label
        movieBudgetLbl.textAlignment = .right
        movieBudgetLbl.adjustsFontSizeToFitWidth = true
        if movieBudgetValue == 0 {
            movieBudgetLbl.text = "Budget is not avaiable"
            movieBudgetAvaiable = false
        } else {
            // Number Formatter
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 0
            let formattedValue = formatter.string(from: NSNumber(value: movieBudgetValue))!
            movieBudgetLbl.text = "Budget: \(String(describing: formattedValue))"
            movieBudgetAvaiable = true
        }
        movieBudgetLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        movieBudgetLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieBudgetLbl.topAnchor.constraint(equalTo: movieSecondPic.topAnchor, constant: 35),
            movieBudgetLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            movieBudgetLbl.widthAnchor.constraint(equalToConstant: 150),
            movieBudgetLbl.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    func configMovieRevenue() {
        scrollView.addSubview(movieRevenueLbl)
        movieRevenueLbl.textColor = .label
        movieRevenueLbl.textAlignment = .right
        movieRevenueLbl.adjustsFontSizeToFitWidth = true
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        let formattedValue = formatter.string(from: NSNumber(value: movieRevenueValue))!
        if movieRevenueValue == 0 {
            movieRevenueLbl.text = "Revenue is not avaiable"
        } else {
            movieRevenueLbl.text = "Revenue: \(formattedValue)"
        }
        movieRevenueLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        movieRevenueLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieRevenueLbl.topAnchor.constraint(equalTo: movieBudgetLbl.bottomAnchor, constant: 10),
            movieRevenueLbl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 5),
            movieRevenueLbl.widthAnchor.constraint(equalToConstant: 150),
            movieRevenueLbl.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    func configOverview() {
        scrollView.addSubview(movieOverview)
        movieOverview.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        movieOverview.isUserInteractionEnabled = false
        movieOverview.textColor = .label
        movieOverview.numberOfLines = 0
        movieOverview.textAlignment = .natural
        if movieOverviewValue == "" {
            movieOverview.text = "No overview available."
        } else {
            movieOverview.text = movieOverviewValue }
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieOverview.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 10),
            movieOverview.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            movieOverview.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 15/16)
        ])
    }
    func configViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.text = movieTitleValue
        self.navigationItem.titleView = titleLabel
    }
    func configScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    func configShadow() {
        scrollView.addSubview(shadow)
        shadow.image = UIImage(named: "shadow")
        shadow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadow.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -20),
            shadow.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            shadow.widthAnchor.constraint(equalToConstant: 195),
            shadow.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
    func configMoviePoster() {
        scrollView.addSubview(moviePoster)
        moviePoster.layer.cornerRadius = 10
        moviePoster.clipsToBounds = true
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            moviePoster.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            moviePoster.widthAnchor.constraint(equalToConstant: 160),
            moviePoster.heightAnchor.constraint(equalToConstant: 230)
        ])
    }
    func configActorsBtn() {
        scrollView.addSubview(actorsBtn)
        actorsBtn.setBackgroundImage(UIImage(named: "actorsBtn"), for: .normal)
        actorsBtn.setBackgroundImage(UIImage(named: "actorsBtnTpd"), for: .highlighted)
        actorsBtn.addTarget(self, action: #selector(actorsBtnTapped), for: .touchUpInside)
        actorsBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actorsBtn.topAnchor.constraint(equalTo: moviePoster.topAnchor, constant: 80),
            actorsBtn.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 15),
            actorsBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            actorsBtn.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    @objc func actorsBtnTapped() {
        let destVC = ActorsTableView()
        destVC.movieId = movieIdValue
        destVC.movieName = movieTitleValue
        navigationController?.pushViewController(destVC, animated: true)
    }
    func configWatchlistBtn() {
        scrollView.addSubview(watchlistBtn)
        // if movie is in Watchlist - button is yellow else is grey
        if movieIdArray.contains(movieIdValue) {
            watchlistBtn.setBackgroundImage(UIImage(named: "addWtchBtnTpd"), for: .normal)
        } else {
            watchlistBtn.setBackgroundImage(UIImage(named: "addWtchBtn"), for: .normal)
        }
        watchlistBtn.addTarget(self, action: #selector(watchlistTapped), for: .touchUpInside)
        watchlistBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            watchlistBtn.bottomAnchor.constraint(equalTo: moviePoster.bottomAnchor),
            watchlistBtn.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 55),
            watchlistBtn.widthAnchor.constraint(equalToConstant: 80),
            watchlistBtn.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
}
