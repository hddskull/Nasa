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
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setUpView(_ view: UIView) {
        view.backgroundColor = .black
        self.apodView = APODView()
        self.apodView?.setConstraints()
        
        guard let aView = apodView
        else { return }
        
        view.addSubview(aView)
        aView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        self.loadingScreen = LoadingScreen()
        self.loadingScreen?.showLoadingScreen(aView)
        self.loadingScreen?.activityIndicator.startAnimating()
    }
    
    func getInfo() {
        APODService.getAPOD(completion: { apodResponse in
            
            DispatchQueue.main.sync {
                self.apodView?.apodName.text = apodResponse.title
                self.apodView?.apodDesc.text = apodResponse.explanation
            }
            
            if apodResponse.media_type == "image"{
                
                guard let stringUrl = apodResponse.hdurl
                else { return }
                
                APODService.getAPODImage(imgUrl: stringUrl) { imageData in

                    self.apodView?.webView.isHidden = true
                    let image = UIImage(data: imageData)
                    self.apodView?.imageView.image = image
                    self.loadingScreen?.activityIndicator.stopAnimating()
                    self.loadingScreen?.backgroundView.isHidden = true
                }

            }
            else if apodResponse.media_type == "video" {
                
                guard let stringUrl = apodResponse.url, let url = URL(string: stringUrl) else { return }
                
                DispatchQueue.main.sync {
                    
                    self.apodView?.imageView.isHidden = true
                    self.apodView?.webView.load(URLRequest(url: url))
                    self.loadingScreen?.activityIndicator.stopAnimating()
                    self.loadingScreen?.backgroundView.isHidden = true
                }
            }
        })
    }
    
}
