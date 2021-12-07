//
//  TabBarController.swift
//  Nasa
//
//  Created by Max Gladkov on 20.10.2021.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    func setUpTabBar() {
        self.tabBar.tintColor = .white
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .black
        let vc1 = APODViewController()
        let vc2 = EarthViewController()
        let vc3 = MarsViewController()
        
        vc1.title = "APOD"
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.title = "Earth"
        vc2.tabBarItem.image = UIImage(systemName: "star")
        vc3.title = "Mars"
        vc3.tabBarItem.image = UIImage(systemName: "m.circle.fill")?.withTintColor(.systemOrange)
        
        self.viewControllers = [vc1, vc2, vc3]
    }
}
