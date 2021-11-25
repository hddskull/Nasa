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

    //MARK: CollectionView setup
    func setUpCV(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (self.view.frame.width - 40)/3, height: (self.view.frame.width - 40)/3)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(MarsImageCell.self, forCellWithReuseIdentifier: MarsImageCell.identifier)
        collectionView.register(MarsCRView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MarsCRView.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
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
    //MARK: Section Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MarsCRView.identifier, for: indexPath) as! MarsCRView
        headerView.backgroundColor = .black
        
        switch indexPath.section {
        case 0:
            headerView.headerLabel.text = "Section 0 header"
            return headerView
        case 1:
            headerView.headerLabel.text = "Section 1 header"
            return headerView
        default:
            headerView.headerLabel.text = ""
            return headerView
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

}
// MARK: UICollectionViewDelegate
extension MarsViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource
extension MarsViewController: UICollectionViewDataSource {


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 10
        case 1:
            return 20
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MarsImageCell

        switch indexPath.section {
        case 0:
            cell.backgroundColor = .white
        case 1:
            cell.backgroundColor = .green
        default:
            cell.backgroundColor = .brown
        }
        
        return cell
    }
}
