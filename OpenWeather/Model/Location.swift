//
//  Location.swift
//  OpenWeather
//
//  Created by yan feng on 2023/5/12.
//

import Foundation

struct Location: Codable, Equatable {
    let lat: Double
    let lon: Double
    let name: String
    
    init(lat: Double = 0.0, lon: Double = 0.0, name: String = "") {
        self.lat = lat
        self.lon = lon
        self.name = name
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.lat == rhs.lat &&
            lhs.lon == rhs.lon &&
            lhs.name == rhs.name
    }
}

struct StoredLocation {
    @LocalStorage(key: "locations") var savedLocationsData: Data? = nil

    func getLocations() -> [Location] {
        var locations = [Location]()

        let decoder = JSONDecoder()
        
        if let data = savedLocationsData,
           let savedLocations = try? decoder.decode([Location].self,
                                                    from: data) {
            locations = savedLocations
        }
        
        return locations
    }
    
    mutating func saveLocation(_ location: Location) {
        
        var locations = getLocations()
        locations.append(location)
        
        let encoder = JSONEncoder()

        if let data = try? encoder.encode(locations) {
            savedLocationsData = data
        }
    }

    mutating func removeLocation(_ location: Location) {
        
        var locations = getLocations()
        locations = locations.filter { $0 != location }
        
        let encoder = JSONEncoder()

        if let data = try? encoder.encode(locations) {
            savedLocationsData = data
        }
    }
    
    mutating func removeAll() {
        savedLocationsData = nil
    }
}
