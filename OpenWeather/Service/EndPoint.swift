//
//  EndPoint.swift
//  OpenWeather
//
//  Created by yan feng on 2023/5/12.
//

import Foundation

enum EndPoint: Hashable {
    case baseURL
    case appid
    case weather
    case latitude
    case longitude
    case geocoding
    case city
    case zipCode
    case countryCode
    case units
    case query
}

extension EndPoint {
    var rawValue: String {
        switch self {
        case .baseURL:
            return "http://api.openweathermap.org/"
        case .weather:
            return "data/2.5/weather"
        case .appid:
            return "appid"
        case .latitude:
            return "lat"
        case .longitude:
            return "lon"
        case .geocoding:
            return "geo/1.0/direct"
        case .query:
            return "q"
        case .city:
            return "city"
        case .zipCode:
            return "zipCode"
        case .countryCode:
            return "countryCode"
        case .units:
            return "units"
        }
    }
}
