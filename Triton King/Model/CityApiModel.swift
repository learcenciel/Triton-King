//
//  CityApiModel.swift
//  Triton King
//
//  Created by Alexander on 31.10.2019.
//  Copyright © 2019 Alexander Team. All rights reserved.
//

import Foundation

struct ResponseObjCity: Codable {
    let statusCode: String
    let responseObj: CityResponse
    
    private enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case responseObj = "response"
    }
}

struct CityResponse: Codable {
    let totalCount: Int
    let cityArray: [CityInfo]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total"
        case cityArray = "items"
    }
}

struct CityInfo: Codable {
    let restaurantId: Int
    let restaurantName: String
    //let restaurantAdress: String
    let restaurantLongitute: Double
    let restaurantLatitude: Double
    //let restaurantPhoneNumber: String
    //let restaurantEmail: String
    //let restaurantDeliveryZone: [Dictionary<Double, Double>]
    
    private enum CodingKeys: String, CodingKey {
        case restaurantId = "id"
        case restaurantName = "name"
        //case restaurantAdress = "address"
        case restaurantLongitute = "longitude"
        case restaurantLatitude = "latitude"
        //case restaurantPhoneNumber = "phone"
        //case restaurantEmail = "email"
}
}
