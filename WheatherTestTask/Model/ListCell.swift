//
//  ListCell.swift
//  WheatherTestTask
//
//  Created by Олег Семёнов on 07.08.2022.
//

import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configure(weather: Weather) {
        
        self.cityLabel.text = weather.cityName
        self.statusLabel.text = weather.conditionString
        self.tempLabel.text = weather.temperatureString
    }
}
