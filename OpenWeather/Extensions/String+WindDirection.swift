//
//  String+WindDirection.swift
//  OpenWeather
//
//  Created by yan feng on 2023/5/12.
//

import Foundation

public extension Int {
    func toWindDirection() -> String {
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let i = Int((Double(self) + 11.25)/22.5)
        return directions[i % 16]
    }
}
