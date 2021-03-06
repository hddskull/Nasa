//
//  MarsViewController.swift
//  Nasa
//
//  Created by Max Gladkov on 20.10.2021.
//

import UIKit

protocol PassEarthParametrs{
    func didGetParametrs(_ date: String)
}
class EarthViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var paramBtn: UIBarButtonItem!
    var collectionView: UICollectionView!
    var cellID = "Cell"
    var imageDataArr: [Data] = []
    var imageNames: [String] = []
    var savedImages: [UIImage] = []
    var currentDate: String!
    var loadingScreen: LoadingScreen?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCV()
        setUpParametrs()
        getImageNames()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.topItem?.rightBarButtonItem = paramBtn
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }

    func setUpCV(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.width)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EarthImageCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemOrange
        view.addSubview(collectionView)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .black
        
        paramBtn = UIBarButtonItem(title: "Earth", style: .plain, target: self, action: #selector(openParametrsView))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = paramBtn
        
        self.loadingScreen = LoadingScreen()
        self.loadingScreen?.showLoadingScreen(self.view)
        self.loadingScreen?.activityIndicator.startAnimating()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! EarthImageCell
        cell.backgroundColor = .brown
        cell.image.image = savedImages[indexPath.row]
        return cell
    }
    
    @objc func openParametrsView(){
        let paramentrVC = EarthParametrsController()
        paramentrVC.parametrDelegate = self
        navigationController?.pushViewController(paramentrVC, animated: true)
    }
    
    func setUpParametrs(){
        if let lastPickedDate = UserDefaults.standard.string(forKey: "lastPickedDateEarth") {
            currentDate = lastPickedDate
        } else {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "YYYY-MM-dd"
            currentDate = dateFormater.string(from: Date())
        }
    }
    
    func getImageNames() {
        self.loadingScreen?.backgroundView.isHidden = false
        self.loadingScreen?.activityIndicator.startAnimating()
        EarthNetworkManager.getEarthImageNames(self.currentDate) { imageNames in
            ImageManager.loadImage(imageNames: imageNames) { images in
                if images.count < 1 {
                    print("no images")
                    EarthNetworkManager.getEarthImages(imageNames, self.currentDate) { imageArr in
                        //image data to UIimage
                        DispatchQueue.global(qos: .utility).async {
                            var images: [UIImage] = []
                            for imageData in imageArr {
                                guard let image = UIImage(data: imageData) else { return }
                                images.append(image)
                            }
                            DispatchQueue.main.sync {
                                self.savedImages = images
                                self.collectionView.reloadData()
                                self.loadingScreen?.activityIndicator.stopAnimating()
                                self.loadingScreen?.backgroundView.isHidden = true
                            }
                        }
                        ImageManager.saveImage(imageNames: imageNames, imageDataArr: imageArr)
                    }
                }
                else {
                    self.savedImages = images
                    self.collectionView.reloadData()
                    self.loadingScreen?.activityIndicator.stopAnimating()
                    self.loadingScreen?.backgroundView.isHidden = true
                }
            }
        }
    }
}

extension EarthViewController: PassEarthParametrs {
    func didGetParametrs(_ date: String) {
        if currentDate != date {
            currentDate = date
            getImageNames()
        }
    }
}
