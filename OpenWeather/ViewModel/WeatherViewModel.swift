//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by yan feng on 2023/5/12.
//

import Foundation
class WeatherViewModel {
    
    private var weather = Observable<Weather?>(nil)
    private var dataManager: Fetchable
    var isLoading = Observable<Bool>(false)
    var error = Observable<NetworkError?>(nil)
    var shouldReloadData = Observable<Bool>(false)
    private var location = Location()
    var weatherFormatted = Observable<WeatherFormatted?>(nil)
    private var storedLocation = StoredLocation()
    
    init(dataManager: Fetchable = DataManager(),
         location: Location = Location()) {
        self.dataManager = dataManager
        self.location = location
    }
    
    func formatWeather(_ weather: Weather) -> WeatherFormatted {
        let temparature = "\(Int(weather.main?.temparature ?? 0.0)) º"
        var condition = ""
        var description = ""
        var image = ""
        if let weathers = weather.weather, weathers.count > 0 {
            condition = weathers[0].main ?? ""
            description = "Humidity \(weather.main?.humidity ?? 0)%  \(weathers[0].weatherDescription?.capitalized ?? "")"
            image = weathers[0].icon ?? ""
        }
        let feelsLike = "Feels like \(Int(weather.main?.feelsLike ?? 0.0)) º"
        let minMaxTemparature = "Day \(Int(weather.main?.tempMax ?? 0.0)) º • Night \(Int(weather.main?.tempMin ?? 0.0)) º"
        var rainPercent: Int = 0
        if let the1H = weather.rain?.the1H {
            rainPercent = Int(the1H * 100)
        } else if let the3H = weather.rain?.the3H {
            rainPercent = Int(the3H * 100)
        } else {
            rainPercent = 0
        }
        let windDirection = weather.wind?.deg?.toWindDirection() ?? ""
        let date = weather.date?.getDateStringFromUnixTime() ?? ""
        
        var weatherFormatted = WeatherFormatted()
        weatherFormatted.temparature = temparature
        weatherFormatted.condition = condition
        weatherFormatted.description = description
        weatherFormatted.image = image
        weatherFormatted.feelsLike = feelsLike
        weatherFormatted.minMaxTemparature = minMaxTemparature
        weatherFormatted.rainPercent = "\(rainPercent)%"
        weatherFormatted.windDirection = windDirection
        weatherFormatted.date = date
        weatherFormatted.locationName = weather.name ?? ""
        return weatherFormatted
    }
}

extension WeatherViewModel {
    func fetchWeather() {
        var request = WeatherRequest()
        request.parameters = [.latitude: "\(location.lat)",
                              .longitude: "\(location.lon)",
                              .units: "imperial"]
        
        isLoading.value = true
        dataManager.fetchData(with: request) { (weather: Weather?, error: NetworkError?) in
            self.isLoading.value = false
            if let weather = weather {
                self.weather.value = weather
                self.weatherFormatted.value = self.formatWeather(weather)
            } else if let error = error {
                self.error.value = error
            }
            self.shouldReloadData.value = true
        }
    }
}

private struct WeatherRequest: APIRequest {
    var method: HTTPMethod = .GET
    var path: EndPoint = .weather
    var parameters: [EndPoint : String] = [:]
    var body: [String : Any]? = nil
}
