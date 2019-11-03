//
//  APIClient.swift
//  Triton King
//
//  Created by Alexander on 31.10.2019.
//  Copyright © 2019 Alexander Team. All rights reserved.
//

import Foundation

class APICLient {
    
    let session = URLSession.shared
    
    func fetchMenu(completionHandler: @escaping (FoodCatalog?, TritonError?) -> Void) {
        let apiManager = BurgerKingApi()
        let baseUrl = apiManager.menuApiUrl
        
        let request = URLRequest(url: URL(string: baseUrl)!)
        
        _ = session.dataTask(with: request, completionHandler: {
            data, response, error in
            DispatchQueue.main.sync {
                guard let data = data else {
                    completionHandler(nil, .parsingError)
                    return
                }
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(ResponseObjMenu.self, from: data)
                    completionHandler(response.responseObj.foodCatalog, nil)
                } catch {
                    completionHandler(nil, .parsingError)
                }
            }
        }).resume()
    }
    
    func fetchCityList(completionHandler: @escaping (ResponseObjCity?, TritonError?) -> Void) {
        let apiManager = BurgerKingApi()
        let baseUrl = apiManager.cityApiUrl
        
        let request = URLRequest(url: URL(string: baseUrl)!)
        
        _ = session.dataTask(with: request, completionHandler: {
            data, response, error in
            DispatchQueue.main.sync {
                guard let data = data else {
                    completionHandler(nil, .parsingError)
                    return
                }
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(ResponseObjCity.self, from: data)
                    completionHandler(response, nil)
                } catch {
                    completionHandler(nil, .parsingError)
                }
            }
        }).resume()
    }
}
