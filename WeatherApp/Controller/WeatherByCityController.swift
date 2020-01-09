//
//  WeatherByCityController.swift
//  WeatherApp
//
//  Created by  Ravi dwivedi on 08/01/2020.
//  Copyright Ravi dwivedi. All rights reserved.
//

import Foundation
import UIKit

class WeatherByCityController: UIViewController {
    
    var delegate: CanReceive?
    
    @IBOutlet weak var updateWeatherButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        updateWeatherButton.setCornerRadius(radius: 5)
        cityTextField.setCornerRadius(radius: 5)
        cityTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        cityTextField.leftViewMode = .always
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateWeatherByCityTapped(_ sender: UIButton) {
        delegate?.receivedCityName(city: cityTextField.text ?? "")
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
}
