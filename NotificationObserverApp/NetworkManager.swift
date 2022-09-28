//
//  NetworkManager.swift
//  NotificationObserverApp
//
//  Created by TTPL on 28/09/22.
//

import Foundation

class NetworkManager {
    
    static func getAPI<T: Decodable>(url: String, resultType: T.Type, complition: @escaping(T)->()) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {return}
            guard let data = data else {return}
            do {
                let decodedResponse = try JSONDecoder().decode(resultType, from: data)
                complition(decodedResponse)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
