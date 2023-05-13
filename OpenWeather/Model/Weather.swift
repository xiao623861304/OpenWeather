//
//  Weather.swift
//  OpenWeather
//
//  Created by yan feng on 2023/5/12.
//

import Foundation

struct Weather: Codable, Identifiable {
    let weather: [WeatherElement]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let rain: Rain?
    let date: Int?
    let id: Int?
    let name: String?
    let sys: System
    
    enum CodingKeys: String, CodingKey {
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case rain
        case date = "dt"
        case id
        case name
        case sys
    }
}

struct System: Codable {
    let type: Int?
    let country: String?
    let id: Int?
    let sunrise: Int?
    let sunset: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case type
        case country
        case id
        case sunrise
        case sunset
    }
}

struct Main: Codable {
    let temparature: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
    let seaLevel: Int?
    let groundLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temparature = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
    }
}

struct WeatherElement: Codable {
    let id: Int?
    let main: String?
    let weatherDescription: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id
        case main
        case weatherDescription = "description"
        case icon
    }
}

struct Rain: Codable {
    let the1H: Double?
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
        case the3H = "3h"
    }
}

struct Clouds: Codable {
    let all: Int?

    enum CodingKeys: String, CodingKey {
        case all
    }
}

struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

struct WeatherFormatted {
    var temparature: String = ""
    var condition: String = ""
    var description: String = ""
    var image: String = ""
    var feelsLike: String = ""
    var minMaxTemparature: String = ""
    var rainPercent: String = ""
    var windDirection: String = ""
    var date: String = ""
    var locationName: String = ""
}
