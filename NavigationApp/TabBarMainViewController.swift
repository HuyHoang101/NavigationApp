//
//  TabBarMainViewController.swift
//  NavigationApp
//
//  Created by hoang.nguyenh on 12/31/25.
//

import UIKit

class TabBarMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let HomeVC = HomeViewController()
        let FavoriteVC = UIViewController()
        FavoriteVC.view.backgroundColor = .systemBackground
        let BookMark = BookmarkViewController()
        let UserVC = UserViewController()
        
        
        //Tab bar items
        HomeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        HomeVC.tabBarItem.tag = 0
        
        FavoriteVC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        FavoriteVC.tabBarItem.tag = 1
        
        BookMark.tabBarItem = UITabBarItem(title: "Bookmark", image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"))
        BookMark.tabBarItem.tag = 2
        
        UserVC.tabBarItem = UITabBarItem(title: "User", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        UserVC.tabBarItem.tag = 3
        
        self.tabBar.tintColor = #colorLiteral(red: 0.7050713543, green: 0.5200051199, blue: 0.9686274529, alpha: 1)
        self.tabBar.unselectedItemTintColor = .systemGray
        
        self.viewControllers = [
            UINavigationController(rootViewController: HomeVC),
            UINavigationController(rootViewController: FavoriteVC),
            UINavigationController(rootViewController: BookMark),
            UINavigationController(rootViewController: UserVC)
        ]
        
    }
    


}
