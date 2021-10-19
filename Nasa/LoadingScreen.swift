//
//  loadingScreen.swift
//  Nasa
//
//  Created by Max Gladkov on 19.10.2021.
//

import UIKit
import SnapKit

class LoadingScreen: UIView {
    
    let activityIndicator = UIActivityIndicatorView()
    let backgroundView = UIView()
    
    func showLoadingScreen(_ view: UIView) {
        
        view.addSubview(backgroundView)
        view.addSubview(activityIndicator)
        
        backgroundView.backgroundColor = .lightGray
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        activityIndicator.style = .large
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(backgroundView)
        }
    }

}
