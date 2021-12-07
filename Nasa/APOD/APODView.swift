//
//  APODView.swift
//  Nasa
//
//  Created by Gladkov Maxim on 16.10.2021.
//

import UIKit
import SnapKit
import WebKit

class APODView: UIView {

    let imageView = UIImageView()
    let webView = WKWebView()
    let apodName = UILabel()
    let apodDesc = UILabel()
    let container = UIStackView()
    let scrollView = UIScrollView()
    
    func setConstraints() {
        self.addSubview(scrollView)
        scrollView.contentSize = container.frame.size
        scrollView.addSubview(container)
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        container.spacing   = 20
        container.axis      = .vertical
        container.alignment = .leading
        
        container.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self)
            make.top.bottom.equalToSuperview()
        }

        container.addArrangedSubview(imageView)
        container.addArrangedSubview(webView)
        container.addArrangedSubview(apodName)
        container.addArrangedSubview(apodDesc)
        
        imageView.backgroundColor = .yellow
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
        
        webView.backgroundColor = .clear
        webView.isOpaque = false
        webView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
        
        apodName.text = "default apod name"
        apodName.backgroundColor = .blue
        apodName.textColor = .black
        apodName.numberOfLines = 0
        
        apodName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        apodDesc.text = "default description \ndefault description \ndefault description \ndefault description \ndefault description \n1111"
        apodDesc.backgroundColor = .blue
        apodDesc.textColor = .black
        apodDesc.textAlignment = .left
        apodDesc.numberOfLines = 0
        
        apodDesc.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    
}
