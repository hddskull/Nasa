//
//  MarsParametrsController.swift
//  Nasa
//
//  Created by Max Gladkov on 27.10.2021.
//

import UIKit
import SnapKit

class EarthParametrsController: UIViewController {

    var parametrDelegate: PassEarthParametrs?
    
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
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 13
        btn.addTarget(self, action: #selector(getDateFromDataPicker), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        view.backgroundColor = .purple

        view.addSubview(datePicker)
        view.addSubview(btn)
        
        datePicker.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
        }
        
        btn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
    }
    
    @objc func getDateFromDataPicker(_ sender: UIButton){
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YYYY-MM-dd"
        let date = dateFormater.string(from: datePicker.date)
        if parametrDelegate != nil {
            parametrDelegate?.didGetParametrs(date)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func passDate(_ date: String, _ completion: @escaping (String) -> Void){
        completion(date)
    }

}
