//
//  NetworkError.swift
//  OpenWeather
//
//  Created by yan feng on 2023/5/12.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case request
    case server
    case noNetwork
    case invalidURL(URL)
    case noData
    case jsonParse
    case incorrectLocation
    case genericError(Any)
    
    var description: String {
        switch self {
        case .request:
            return "The request failed due to an error in the request."
        case .server:
            return "The request failed due to a server-side error."
        case .noNetwork:
            return "It seems the device is not connected to internet. Please check your internet connection."
        case .invalidURL(let url):
            return "Invalid URL: \(url)."
        case .noData:
            return "No Data received from the server."
        case .jsonParse:
            return "There is an error occured while parsing JSON data."
        case .incorrectLocation:
            return "Please ensure your input follows the correct format: cityName,zipcode or cityName"
        case .genericError(let any):
            return "Error occured: \(any)"
        }
    }
}
