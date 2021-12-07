//
//  MarsViewController.swift
//  Nasa
//
//  Created by Max Gladkov on 24.11.2021.
//

import UIKit

protocol PassMarsParametrs {
    func didGetParametrs (rover: RoverName, camera: RoverCamera, date: String)
}

private let reuseIdentifier = "MarsImageCell"

class MarsViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    private var paramBtn: UIBarButtonItem!
    private var collectionView: UICollectionView!
    private var cameras: [String] = []
    private var groupedMarsModelPhoto: [[MarsModelPhoto]] = [[],[],[],[],[],[],[]]
    private var groupedMarsImages: [[UIImage]] = [[],[],[],[],[],[],[]]
    private var marsData: [MarsModelPhoto] = []
    
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCV()
        getMarsImages(rover: .Curiosity, camera: .all, date: "2021-07-20")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.topItem?.rightBarButtonItem = paramBtn
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
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
        
        paramBtn = UIBarButtonItem(title: "Mars", style: .plain, target: self, action: #selector(openParametrsView))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = paramBtn
//        
//        self.loadingScreen = LoadingScreen()
//        self.loadingScreen?.showLoadingScreen(self.view)
//        self.loadingScreen?.activityIndicator.startAnimating()
    }
    //MARK: Section Header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MarsCRView.identifier, for: indexPath) as! MarsCRView
        headerView.backgroundColor = .black
        guard self.cameras.count != 0
        else { return headerView }
        headerView.headerLabel.text = self.cameras[indexPath.section]
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    //MARK: Get Mars Images
    
    func getMarsImages(rover: RoverName, camera: RoverCamera, date: String) {
        MarsNetworkManager.getMarsPhotoData(forRover: rover, camera: camera, date: date) { marsModelPhotos in
                
            self.marsData = marsModelPhotos.photos
            
            self.cameras = Array( Set( marsModelPhotos.photos.map({ marsModelPhoto in
                marsModelPhoto.camera.full_name
            }) ) )
            
            DispatchQueue.main.sync {
                
                self.collectionView.reloadData()
            }
            
            let lock = NSLock()
            for i in 0..<self.cameras.count {
                
                let arr = self.marsData.filter { model in
                    model.camera.full_name == self.cameras[i]
                }
                self.groupedMarsModelPhoto[i] = arr
                
                for model in arr {
                    
                    MarsNetworkManager.getMarsImage(urlString: model.img_src) { imageData in
                        guard let marsImage = UIImage(data: imageData)
                        else { return }
                        lock.lock()
                        self.groupedMarsImages[i].append(marsImage)
                        lock.unlock()
                        DispatchQueue.main.sync {
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
        }
        
    }
    
    //MARK: Funcs
    
    @objc func openParametrsView(){
        
        let paramentrVC = MarsParametrsController()
        paramentrVC.parametrDelegate = self
        navigationController?.pushViewController(paramentrVC, animated: true)
    }

}

// MARK: UICollectionViewDelegate
extension MarsViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource
extension MarsViewController: UICollectionViewDataSource {


    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return cameras.count
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groupedMarsImages[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MarsImageCell
        cell.imageView.image = groupedMarsImages[indexPath.section][indexPath.row]
        
        return cell
    }
}

extension MarsViewController: PassMarsParametrs {
    func didGetParametrs(rover: RoverName, camera: RoverCamera, date: String) {
        
        self.cameras = []
        self.groupedMarsModelPhoto = [[],[],[],[],[],[],[]]
        self.groupedMarsImages = [[],[],[],[],[],[],[]]
        self.marsData = []
        getMarsImages(rover: rover, camera: camera, date: date)
    }
    
}
