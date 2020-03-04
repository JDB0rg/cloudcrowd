//
//  Weather.swift
//  Clouds
//
//  Created by Madison Waters on 10/22/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import Foundation

struct WeatherObject: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
}

struct Coord: Codable {
    let lon: Int
    let lat: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

struct Clouds: Codable {
  let all: Int
}
