//
//  ProductCell.swift
//  Triton King
//
//  Created by Alexander on 01.11.2019.
//  Copyright © 2019 Alexander Team. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    
    func setup(for foodInfo: FoodInfo) {
        let url = URL(string: foodInfo.imageCommonSizePath ?? "")
        
        foodNameLabel.text = foodInfo.foodName
        foodImageView.kf.setImage(with: url)
    }
}
