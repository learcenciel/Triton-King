//
//  APIClient.swift
//  Triton King
//
//  Created by Alexander on 31.10.2019.
//  Copyright © 2019 Alexander Team. All rights reserved.
//

import Foundation

class APICLient {
    lazy var session = URLSession.shared
    var foodToShow: ResponseObj? = nil
    
    init() {
        fetchFoodFromServer()
    }
    
    func fetchFoodFromServer() {
        let baseUrl = "https://orderapp.burgerking.ru/api/v1/menu/getCatalog"
        let request = URLRequest(url: URL(string: baseUrl)!)
        
        _ = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            
            guard let data = data else { return }
            
            do {
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(ResponseObj.self, from: data)
                self.foodToShow = response
            } catch {
                print(error)
            }
            
            }).resume()
    }
}
