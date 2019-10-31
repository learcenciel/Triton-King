//
//  CategoryCell.swift
//  Triton King
//
//  Created by Alexander on 31.10.2019.
//  Copyright © 2019 Alexander Team. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    @IBOutlet weak var foodInfoLabel: UILabel!
    
    func setup(for foodInfo: FoodCategories) {
        foodInfoLabel.text = foodInfo.categoryName
    }
}
