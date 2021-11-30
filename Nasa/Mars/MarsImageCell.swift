//
//  MarsImageCell.swift
//  Nasa
//
//  Created by Max Gladkov on 24.11.2021.
//

import UIKit

class MarsImageCell: UICollectionViewCell {
    
    static let identifier = "MarsImageCell"
    
    var imageView: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    func setUpCell(){
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
