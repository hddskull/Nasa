//
//  ViewController.swift
//  Nasa
//
//  Created by Gladkov Maxim on 16.10.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        makeConstraints()
    }
    
    
    let newView: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        return v
    }()

    
    func makeConstraints() {
        view.addSubview(newView)
        newView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(400)
        }
    }
}

