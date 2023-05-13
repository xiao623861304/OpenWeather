//
//  LocationViewModel.swift
//  OpenWeather
//
//  Created by yan feng on 2023/5/12.
//

import Foundation

class LocationViewModel {
    private var dataManager: Fetchable
    var isLoading = Observable<Bool>(false)
    var error = Observable<NetworkError?>(nil)
    var storeLocation = Observable<Location?>(nil)
    private var storedLocation = StoredLocation()
    var storedLocations = Observable<[Location]>([])
    
    init(dataManager: Fetchable = DataManager()) {
        self.dataManager = dataManager
    }

    func convertToGeoCoordinates(_ text: String?) {
        var request = GeoCoordinatesRequest()
        if let text = text {
            request.parameters = [.query: text]
        }
        
        isLoading.value = true
        dataManager.fetchData(with: request) { [weak self] (location: Location?, error: NetworkError?) in
            guard let self = self else { return }
            self.isLoading.value = false
            if let location = location {
                if !self.storedLocation.getLocations().contains(location) {
                    self.storedLocation.saveLocation(location)
                    self.fetchStoredLocations()
                }
            } else if let error = error {
                self.error.value = error
            }
        }
    }
    
    func fetchStoredLocations() {
        storedLocations.value = storedLocation.getLocations()
    }

    func saveCurrentLocation(lat: Double, lon: Double) {
        storedLocation.saveLocation(Location(lat: lat, lon: lon, name: "Current Location"))
        fetchStoredLocations()
    }
}

private struct GeoCoordinatesRequest: APIRequest {
    var method: HTTPMethod = .GET
    var path: EndPoint = .geocoding
    var parameters: [EndPoint : String] = [:]
    var body: [String : Any]? = nil
}
