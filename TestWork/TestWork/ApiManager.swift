//
//  ApiManager.swift
//  TestWork
//
//  Created by Natalie Mikheeva on 16.08.2023.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2023-07-14&sortBy=publishedAt&apiKey=be4975f02b964a008b5186c21ec7ccab"
    
    func getWeather() {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            print(response)
        }
        task.resume()
    }
}
