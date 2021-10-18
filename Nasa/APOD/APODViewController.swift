//
//  APODViewController.swift
//  Nasa
//
//  Created by Gladkov Maxim on 16.10.2021.
//

import UIKit

class APODViewController: UIViewController {
    
    var apodView: APODView?
    var apodService: APODService?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView(self.view)
        
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
    }
    
    func getInfo() {
        self.apodService = APODService()
        apodService?.getAPOD()
        DispatchQueue.main.async {
            guard let apodModel = self.apodService?.APODResponse else { return }
            
            self.apodView?.apodName.text = apodModel.apodName
            self.apodView?.apodDesc.text = apodModel.apodDescription
            self.apodView?.imageView.image = apodModel.
        }
        //Проблема с взятием изображения из ссылки и вставкой его в изображение
        

    }

}
