//
//  WeatherData.swift
//  WheatherTestTask
//
//  Created by Олег Семёнов on 06.08.2022.
//

import Foundation

struct WeatherData: Codable {
    
    let geoObject: GeoObject
    let fact: Fact
    let forecasts: [Forecast]
    
//    enum CodingKeys: String, CodingKey {
//        case fact
//        case forecasts
//        case geoObject = "geo_object"
//    }
}

struct Fact: Codable {
    
    let temp: Int
    let icon: String //*/
    let condition: String //*/
    let windSpeed: Double
    let pressureMm: Int
    
//    enum CodingKeys: String, CodingKey {
//
//        case temp
//        case icon
//        case condition
//        case windSpeed = "wind_speed"
//        case pressureMm = "pressure_mm"
        
//    }
}

struct GeoObject: Codable {
    let locality: Country
}

struct Country: Codable {
    let name: String
}

struct Forecast: Codable {
    let parts: Parts
}

struct Parts: Codable {
    let day: Day
}

struct Day: Codable {
    let tempMin, tempMax: Int?
    
//    enum CodingKeys: String, CodingKey {
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//    }
}
