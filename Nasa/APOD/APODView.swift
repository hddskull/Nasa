//
//  APODView.swift
//  Nasa
//
//  Created by Gladkov Maxim on 16.10.2021.
//

import UIKit
import SnapKit

class APODView: UIView {

    let imageView = UIImageView()
    let apodName = UITextField()
    let apodDesc = UITextView()
    
    func setConstraints() {
        self.addSubview(imageView)
        self.addSubview(apodName)
        self.addSubview(apodDesc)
        
        imageView.backgroundColor = .yellow
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(400)
        }
        apodName.text = "default apod name"
        apodName.backgroundColor = .clear
        apodName.textColor = .black
        apodName.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).inset(10)
            make.height.equalTo(50)
        }
        
        apodDesc.text = "default description /ndefault description /ndefault description /ndefault description /ndefault description /n"
        apodDesc.backgroundColor = .clear
        apodDesc.textColor = .black
        apodDesc.textAlignment = .left
        apodDesc.snp.makeConstraints { make in
            make.top.equalTo(apodName.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).inset(10)
            make.height.equalTo(400)
        }
    }
    
    
}
