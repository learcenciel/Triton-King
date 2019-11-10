//
//  MenuLookViewController.swift
//  Triton King
//
//  Created by Alexander on 31.10.2019.
//  Copyright © 2019 Alexander Team. All rights reserved.
//

import UIKit

class MenuLookViewController: UIViewController {
    
    @IBOutlet weak var foodCategoryTableView: UITableView!
    
    private let apiClient = APICLient()
    var foodCatalog: FoodCatalog?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMenu()
    }
    
    private func fetchMenu() {
        apiClient.fetchMenu { [weak self] foodCatalog, error in
            if let error = error {
                if error == .parsingError {
                    self?.showMessage("Ошибка парсинга данных")
                }
                return
            }
            
            self?.foodCatalog = foodCatalog
            self?.foodCategoryTableView.reloadData()
        }
    }
    
    private func showMessage(_ message: String) {
        let alertViewController = UIAlertController(title: "Triton", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertViewController.addAction(okAction)
        present(alertViewController, animated: true)
    }
}


extension MenuLookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return foodCatalog?.foodCategories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let category = foodCatalog?.foodCategories[section] else { fatalError("KEK") }
        return category.categoryName
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        cell.onProductTap = { [weak self] product in
            self?.showMessage(product.foodName)
        }
        
        guard let category = foodCatalog?.foodCategories[indexPath.section] else { fatalError("KEK") }
        cell.setup(for: category)
        
        return cell
    }

}
