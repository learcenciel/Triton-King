//
//  FoodCheckViewController.swift
//  Triton King
//
//  Created by Alexander on 11.11.2019.
//  Copyright © 2019 Alexander Team. All rights reserved.
//

import UIKit
import Kingfisher

class FoodCheckViewController: UIViewController {
    @IBOutlet weak var foodImage: UIImageView!
    //@IBOutlet weak var foodCounterStepper: UIStepper!
    //@IBOutlet weak var foodSettingsInfoSegment: UISegmentedControl!
    @IBOutlet weak var foodDescriptionTextView: UITextView!
    @IBOutlet weak var foodMadeOfTextView: UITextView!
    //@IBOutlet weak var foodValueChangeSegment: UISegmentedControl!
    @IBOutlet weak var foodDetailsStackView: UIStackView!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodWeightLabel: UILabel!
    @IBOutlet weak var foodCountLabel: UILabel!
    let foodPrice = Int.random(in: 1..<289)
    
    var foodInfoToShow: FoodInfo?
    
    override func viewDidLoad() {
        let url = URL(string: foodInfoToShow?.imageCommonSizePath ?? "")
        foodImage.kf.setImage(with: url)
        foodDescriptionTextView.text = foodInfoToShow?.foodDescription
        foodMadeOfTextView.text = foodInfoToShow?.foodDetailInfo.foodCompositionInfo.foodComposition
        foodWeightLabel.text = String((foodInfoToShow?.foodDetailInfo.foodCompositionInfo.foodWeight)!) + " г"
        foodPriceLabel.text = "0"
        fetchFoodComposition(for: (foodInfoToShow?.foodDetailInfo.foodCompositionInfo)!)
        
        super.viewDidLoad()
    }
    
    
    
    @IBAction func foodCountChange(_ sender: UIStepper) {
        foodCountLabel.text = String(Int(sender.value))
        let foodCount = (foodCountLabel.text)!
        
        foodPriceLabel.text = String((Int(foodCount))! * foodPrice)
    }
    
    func fetchFoodComposition(for foodCompositionInfo: FoodCompositionInfo) {
        let listOfLabels = foodDetailsStackView.arrangedSubviews
        
        var i = 0
        let listOfFoodValues = [foodCompositionInfo.foodKj100G, foodCompositionInfo.foodKcal100G, foodCompositionInfo.foodFats100G, foodCompositionInfo.foodCarbs100G, foodCompositionInfo.foodProtein100G]
        for elem in listOfLabels {
            if let label = elem as? UILabel {
                label.text = String(listOfFoodValues[i])
                i += 1
            }
        }
    }
}
