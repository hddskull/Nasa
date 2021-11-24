//
//  MarsViewController.swift
//  Nasa
//
//  Created by Max Gladkov on 24.11.2021.
//

import UIKit

private let reuseIdentifier = "MarsImageCell"

class MarsViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCV()
        
    }

    func setUpCV(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (self.view.frame.width - 40)/3, height: (self.view.frame.width - 40)/3)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(MarsImageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        view.backgroundColor = .systemOrange
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .black
        
//        let paramBtn = UIBarButtonItem(title: "Параметры", style: .plain, target: self, action: #selector(openParametrsView))
//        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = paramBtn
//        
//        self.loadingScreen = LoadingScreen()
//        self.loadingScreen?.showLoadingScreen(self.view)
//        self.loadingScreen?.activityIndicator.startAnimating()
    }




}
// MARK: UICollectionViewDelegate
extension MarsViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource
extension MarsViewController: UICollectionViewDataSource {


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        guard let marsCell = cell as? MarsImageCell
        else { return cell }
        
        marsCell.backgroundColor = .brown
    
        return cell
    }
}
