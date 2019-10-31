//
//  MenuApiModel.swift
//  Triton King
//
//  Created by Alexander on 31.10.2019.
//  Copyright © 2019 Alexander Team. All rights reserved.
//

import Foundation

struct ResponseObj: Codable {
    let statusCode: String
    let responseObj: FoodResponse
    
    private enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case responseObj = "response"
    }
}

struct FoodResponse: Codable {
    let hash: String
    let foodCatalog: FoodCatalog
    
    private enum CodingKeys: String, CodingKey {
        case hash
        case foodCatalog = "catalog"
    }
}

struct FoodCatalog: Codable {
    let foodCategories: [FoodCategories]

    private enum CodingKeys: String, CodingKey {
        case foodCategories = "categories"
    }
}

struct FoodCategories: Codable {
    let categoryId: Int
    let categoryName: String
    let imageCommonSizePath: String
    let foodInfo: [FoodInfo]
    
    private enum CodingKeys: String, CodingKey {
        case categoryId = "id"
        case categoryName = "name"
        case imageCommonSizePath = "image"
        case foodInfo = "dishes"
    }
}

struct FoodInfo: Codable {
    let foodId: Int
    let foodName: String
    let imageCommonSizePath: String?
    let foodDescription: String
    let foodMaxCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case foodId = "id"
        case foodName = "name"
        case imageCommonSizePath = "image"
        case foodDescription = "description"
        case foodMaxCount = "max_count"
    }
 }
