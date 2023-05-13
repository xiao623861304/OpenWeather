//
//  TimeStamp+Date.swift
//  OpenWeather
//
//  Created by yan feng on 2023/5/12.
//

import Foundation

extension Int {
    func getDateStringFromUnixTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE dd | hh:mm a" //Mon 12 | 06:00 PM
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
}
