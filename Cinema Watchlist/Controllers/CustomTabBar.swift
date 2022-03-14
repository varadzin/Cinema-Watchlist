//
//  CustomTabBar.swift
//  Watchlist
//
//  Created by Frantisek Varadzin on 11/04/2021.
//

import UIKit

class CustomTabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let bar1 = createTabBaerController(vc: SearchViewController(), title: "Search", image: #imageLiteral(resourceName: "search"))
        let bar2 = createTabBaerController(vc: FavoritesViewController(), title: "Favorites Actors", image: #imageLiteral(resourceName: "favourite"))
        let bar3 = createTabBaerController(vc: WatchlistViewController(), title: "My Watchlist", image: #imageLiteral(resourceName: "bookmark"))
        viewControllers = [bar1, bar2, bar3]
    }
    func createTabBaerController(vc: UIViewController, title: String, image: UIImage) -> UINavigationController {
        vc.navigationItem.title = title
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
