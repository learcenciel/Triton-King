//
//  MenuApiModel.swift
//  Triton King
//
//  Created by Alexander on 31.10.2019.
//  Copyright © 2019 Alexander Team. All rights reserved.
//

import Foundation

struct ResponseObjMenu: Codable {
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
    let foodCategories: [FoodCategory]
    
    private enum CodingKeys: String, CodingKey {
        case foodCategories = "categories"
    }
}

struct FoodCategory: Codable {
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
    let foodDetailInfo: FoodDetailInfo
    
    private enum CodingKeys: String, CodingKey {
        case foodId = "id"
        case foodName = "name"
        case imageCommonSizePath = "image_128"
        case foodDescription = "description"
        case foodMaxCount = "max_count"
        case foodDetailInfo = "info"
    }
}

struct FoodDetailInfo: Codable {
    let foodCompositionInfo: FoodCompositionInfo
    
    private enum CodingKeys: String, CodingKey {
        case foodCompositionInfo = "composition"
    }
}

struct FoodCompositionInfo: Codable {
    let foodComposition: String
    let foodWeight: Double
    let foodKjAll: Double
    let foodKj100G: Double
    let foodKcalAll: Double
    let foodKcal100G: Double
    let foodFatsAll: Double
    let foodFats100G: Double
    let foodCarbsAll: Double
    let foodCarbs100G: Double
    let foodProteinAll: Double
    let foodProtein100G: Double
    
    private enum CodingKeys: String, CodingKey {
        case foodComposition = "composition_text"
        case foodWeight = "weight"
        case foodKjAll = "kj"
        case foodKj100G = "kj_100"
        case foodKcalAll = "kcal"
        case foodKcal100G = "kcal_100"
        case foodFatsAll = "fats"
        case foodFats100G = "fats_100"
        case foodCarbsAll = "carbs"
        case foodCarbs100G = "carbs_100"
        case foodProteinAll = "protein"
        case foodProtein100G = "protein_100"
    }
}
