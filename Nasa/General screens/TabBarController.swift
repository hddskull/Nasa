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
        let vc1 = APODViewController()
        let vc2 = MarsViewController(collectionViewLayout: UICollectionViewLayout())
        
        vc1.title = "APOD"
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.title = "Mars"
        vc2.tabBarItem.image = UIImage(systemName: "star")
        
//        guard let items = self.tabBar.items else {
//            return
//        }
//        let images = ["house", "star"]
//        for i in 0..<items.count {
//            items[i].image = UIImage(systemName: images[i])
//        }
        
        self.viewControllers = [vc1, vc2]
//        self.modalPresentationStyle = .fullScreen
//        present(self, animated: true)
    }
}