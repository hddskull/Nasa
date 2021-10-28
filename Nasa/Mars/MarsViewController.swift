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
    var imageNames: [String] = []
    var savedImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCV()
        getImageNames()
        
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
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .black
        
        let paramBtn = UIBarButtonItem(title: "Параметры", style: .plain, target: self, action: #selector(openParametrsView))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = paramBtn
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MarsImageCell
        cell.backgroundColor = .brown
        cell.image.image = savedImages[indexPath.row]
        return cell
    }
    
    @objc func openParametrsView(){
        navigationController?.pushViewController(MarsParametrsController(), animated: true)
    }
    
    func getImageNames() {
        MarsNetworkManager.getMarsImageNames { imageNames in
            print(imageNames)
            ImageManager.loadImage(imageNames: imageNames) { images in
                if images.count < 1 {
                    print("no images")
                    MarsNetworkManager.getMarsImages(imageNames) { imageArr in
                        ImageManager.saveImage(imageNames: imageNames, imageDataArr: imageArr) { smt in
                            ImageManager.loadImage(imageNames: imageNames) { images in
                                self.savedImages = images
                                self.collectionView.reloadData()
                            }
                        }
                    }
                }
                else {
                    self.savedImages = images
                    self.collectionView.reloadData()
                }
                
            }

        }
    }
}
