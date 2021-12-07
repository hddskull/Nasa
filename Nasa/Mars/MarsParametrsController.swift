//
//  MarsParametrsController.swift
//  Nasa
//
//  Created by Max Gladkov on 06.12.2021.
//

import UIKit
import SnapKit

class MarsParametrsController: UIViewController {

    var parametrDelegate: PassMarsParametrs?
    let rovers: [RoverName] = [.Curiosity, .Opportunity, .Spirit]
    let roverCameras: [[RoverCamera]] = [[.FHAZ, .RHAZ, .MAST, .CHEMCAM, .MAHLI, .MARDI, .NAVCAM, .all],
                                         [.FHAZ, .RHAZ, .NAVCAM, .PANCAM, .MINITES, .all],
                                         [.FHAZ, .RHAZ, .NAVCAM, .PANCAM, .MINITES, .all]]
    
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
        btn.addTarget(self, action: #selector(passDataBack), for: .touchUpInside)
        return btn
    }()
    
    let roverPicker: UIPickerView = {
        let pckr = UIPickerView()
        return pckr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        roverPicker.delegate = self
        roverPicker.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setUpView() {
        view.backgroundColor = .purple

        view.addSubview(datePicker)
        view.addSubview(btn)
        view.addSubview(roverPicker)
        
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
        
        roverPicker.snp.makeConstraints { make in
            make.bottom.equalTo(datePicker.snp.top).inset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
    }
    
    @objc func passDataBack(_ sender: UIButton){
        
        let roverIndex = roverPicker.selectedRow(inComponent: 0)
        let rover = rovers[roverIndex]
        
        let cameraIndex = roverPicker.selectedRow(inComponent: 1)
        let camera = roverCameras[roverIndex][cameraIndex]
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YYYY-MM-dd"
        let date = dateFormater.string(from: datePicker.date)
        
        if parametrDelegate != nil {
            parametrDelegate?.didGetParametrs(rover: rover, camera: camera, date: date)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
//    func passDate(_ date: String, _ completion: @escaping (String) -> Void){
//        completion(date)
//    }

}

//MARK: picker view set up

extension MarsParametrsController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return rovers.count
        case 1:
            let firstComponent = pickerView.selectedRow(inComponent: 0)
            return roverCameras[firstComponent].count
        default:
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return rovers[row].rawValue
        case 1:
            let firstComponent = pickerView.selectedRow(inComponent: 0)
            guard roverCameras[firstComponent][row] != .all
            else { return "all" }
            return roverCameras[firstComponent][row].rawValue.trimmingCharacters(in: CharacterSet(charactersIn: "="))
        default:
            return "smt"
        }
    }
    
}

