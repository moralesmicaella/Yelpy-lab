//
//  API.swift
//  Yelpy
//
//  Created by Micaella Morales on 2/18/21.
//

import Foundation

struct API {
    
    static func getRestaurants(completion: @escaping ([Restaurant]?) -> Void) {
        
        let apikey = "1_Dn3Ov33tr9BjSlQw6UXooLDNjM3paBeyqgNga9YkQz6J0O9Jnxwe1Fj3N2Wy6OEKOvIif5bw5hI33nzp3b9al26uA33UaBniIkKhKcZtL2q9nE3rv6FDJ5omIvYHYx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                // Get data from API and return it using completion
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let restDictionaries = dataDictionary["businesses"] as! [[String: Any]]
                
                var restaurants: [Restaurant] = []
                
                for dictionary in restDictionaries {
                    let restaurant = Restaurant.init(dict: dictionary)
                    restaurants.append(restaurant)
                }
                
                return completion(restaurants)
                
                }
            }
        
            task.resume()
        
        }
    }

