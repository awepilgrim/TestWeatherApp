//
//  DetailVC.swift
//  WheatherTestTask
//
//  Created by Олег Семёнов on 08.08.2022.
//

import UIKit
import SwiftSVG

class DetailVC: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityConditionView: UIView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weatherModel = Weather()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshLabels()
    }
    
    func refreshLabels() {
        
        self.cityNameLabel.text = weatherModel.cityName
        
        let svgUrl = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weatherModel.conditionCode).svg")
        let svgImage = UIView(SVGURL: svgUrl!) { image in
            image.resizeToFit(self.cityConditionView.bounds)
        }
        self.cityConditionView.addSubview(svgImage)
        
        self.conditionLabel.text = "\(weatherModel.conditionString)"
        self.pressureLabel.text = "\(weatherModel.pressureMm)"
        self.windSpeedLabel.text = "\(weatherModel.windSpeed)"
        self.tempMaxLabel.text = "\(weatherModel.tempMax)"
        self.tempMinLabel.text = "\(weatherModel.tempMin)"
        self.temperatureLabel.text = weatherModel.temperatureString
    }

}
