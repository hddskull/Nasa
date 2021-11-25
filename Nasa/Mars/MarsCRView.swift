//
//  MarsCRView.swift
//  Nasa
//
//  Created by Max Gladkov on 25.11.2021.
//

import UIKit

class MarsCRView: UICollectionReusableView {
    
    static let identifier = "MarsCRVIew"
    
    let headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .black
        lbl.textColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
