//
//  MarsImageCell.swift
//  Nasa
//
//  Created by Max Gladkov on 20.10.2021.
//

import UIKit
import SnapKit

class MarsImageCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    func setUpCell(){
        self.addSubview(image)
        image.snp.makeConstraints { make in
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
