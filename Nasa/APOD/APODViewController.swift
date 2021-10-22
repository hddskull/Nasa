//
//  APODViewController.swift
//  Nasa
//
//  Created by Gladkov Maxim on 16.10.2021.
//

import UIKit

class APODViewController: UIViewController {
    
    var apodView: APODView?
    var loadingScreen: LoadingScreen?
    var imageUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView(self.view)
        getInfo()
    }
    
    func setUpView(_ view: UIView) {
        view.backgroundColor = .green
        self.apodView = APODView()
        self.apodView?.setConstraints()
        guard let aView = apodView else { return }
        view.addSubview(aView)
        aView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        self.loadingScreen = LoadingScreen()
        self.loadingScreen?.showLoadingScreen(aView)
        self.loadingScreen?.activityIndicator.startAnimating()
    }
    
    func getInfo() {
        APODService.getAPOD(completion: { apodResponse, imageData in
            self.loadingScreen?.activityIndicator.stopAnimating()
            self.loadingScreen?.backgroundView.isHidden = true
            self.apodView?.apodName.text = apodResponse.title
            self.apodView?.apodDesc.text = apodResponse.explanation
            let image = UIImage(data: imageData)
            self.apodView?.imageView.image = image
        })
    }
    
}
