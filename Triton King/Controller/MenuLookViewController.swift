//
//  MenuLookViewController.swift
//  Triton King
//
//  Created by Alexander on 31.10.2019.
//  Copyright © 2019 Alexander Team. All rights reserved.
//

import UIKit

class MenuLookViewController: UIViewController {
    let foodToShow = APICLient()
    @IBOutlet weak var foodCategoryTableView: UITableView!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
}


extension MenuLookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodToShow.foodToShow?.responseObj.foodCatalog.foodCategories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        cell.setup(for: (foodToShow.foodToShow?.responseObj.foodCatalog.foodCategories[indexPath.row])!)
        return cell
    }
    
    @objc func timerAction() {
        self.foodCategoryTableView.reloadData()
    }
}
