//
//  MarsParametrsController.swift
//  Nasa
//
//  Created by Max Gladkov on 27.10.2021.
//

import UIKit
import SnapKit

class EarthParametrsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.preferredDatePickerStyle = .wheels
        dp.datePickerMode = .date
        dp.backgroundColor = .black
        dp.tintColor = .white
        dp.clipsToBounds = true
        dp.layer.cornerRadius = 20
        return dp
    }()
    
    let btn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Apply", for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .black
        return btn
    }()
    
    func setUpView() {
        view.addSubview(datePicker)
        view.backgroundColor = .purple
        
        datePicker.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
    }

}
