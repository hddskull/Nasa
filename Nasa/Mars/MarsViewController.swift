//
//  MarsViewController.swift
//  Nasa
//
//  Created by Max Gladkov on 20.10.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class MarsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView!
    var cellID = "Cell"
    var imageDataArr: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCV()
        getMarsImages()
        
    }
    
    func setUpCV(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.width)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MarsImageCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemOrange
        view.addSubview(collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MarsImageCell
        //configure image into cell
        cell.backgroundColor = .brown
        cell.image.image = UIImage(data: imageDataArr[indexPath.row])
        return cell
    }
    
    func getMarsImages() {
        MarsNetworkManager.getMarsImage { dataArr in
            print(dataArr)
            self.imageDataArr = dataArr
            self.collectionView.reloadData()
        }
    }
}
