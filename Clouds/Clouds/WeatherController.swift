//
//  WeatherController.swift
//  Clouds
//
//  Created by Madison Waters on 1/13/20.
//  Copyright © 2020 EmPact. All rights reserved.
//

import Foundation

class WeatherController {
    
//    func fetchWeather(lon: Int, lat:Int, completion: @escaping ((Error?) -> Void) = {_ in}) {
//        var baseURL: URL! {return URL(string: "api.openweathermap.org/data/2.5/weather")} // "?lat=35&lon=139"
//        var apiKey = "ChangeThisToBeTheApiKeyWhenReady"
//        
//        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
//            NSLog("Error: unable to resolve baseURL to components")
//            return
//        }
//        
//        let queryLonItem = URLQueryItem(name: "lon", value: "\(lon)")
//        let queryLatItem = URLQueryItem(name: "lat", value: "\(lat)")
//        let queryKeyItem = URLQueryItem(name: "apikey", value: apiKey)
//        
//        components.queryItems = [queryLatItem, queryLonItem, queryKeyItem]
//        let requestURL = components.url
//        print("requestURL: \(requestURL!)")
//        
//        URLSession.shared.dataTask(with: requestURL!) { (data, _, error) in
//        
//            if let error = error {
//                NSLog("Error fetching users from data task.")
//                completion(error)
//                return
//            }
//            
//            guard let data = data else {
//                NSLog("No data returned from data task.")
//                completion(NSError())
//                return
//            }
//            
//            do {
//                let _ = try JSONDecoder().decode(WeatherData.self, from: data)
//                completion(nil)
//            } catch {
//                NSLog("Error decoding WeatherData: \(error)")
//                completion(error)
//            }
//        }.resume()
//    }
    
}
