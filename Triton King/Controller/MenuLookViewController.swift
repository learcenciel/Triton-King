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
    
    var dataToPass: FoodInfo?
    
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let category = foodCatalog?.foodCategories[section] else { fatalError("KEK") }
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let block = UIView()
        block.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height - 20)
        block.backgroundColor = .white
        block.alpha = 1.0
        
        let label = UILabel()
        label.frame = CGRect.init(x: 15, y: 0, width: headerView.frame.width, height: headerView.frame.height - 20)
        label.text = category.categoryName
        label.textColor = .brown
        
        block.addSubview(label)
        
        headerView.addSubview(block)
        
        return headerView
    }
    
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
        return 105.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        cell.onProductTap = { [weak self] product in
            self?.dataToPass = product
            self?.performSegue(withIdentifier: "justSegue", sender: nil)
        }
        
        guard let category = foodCatalog?.foodCategories[indexPath.section] else { fatalError("KEK") }
        cell.setup(for: category)
        
        let separatorLine = UIView.init(frame: CGRect(x: 0, y: cell.frame.height - 1, width: cell.frame.width, height: 1))
        separatorLine.backgroundColor = .black
        cell.addSubview(separatorLine)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! FoodCheckViewController
        vc.foodInfoToShow = self.dataToPass
    }
}
