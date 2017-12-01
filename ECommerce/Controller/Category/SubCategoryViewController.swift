//
//  SubCategoryViewController.swift
//  ECommerce
//
//  Created by Atinderpal Singh on 29/11/17.
//  Copyright © 2017 Abc. All rights reserved.
//

import UIKit

class SubCategoryViewController: UIViewController {
    @IBOutlet weak var tableviewCategory: UITableView!

    var subCategory = [ProductCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableviewCategory.tableFooterView = UIView.init()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SubCategoryViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return subCategory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.selectionStyle = .none

        let category: ProductCategory = self.subCategory[indexPath.row]
        cell?.textLabel?.text = category.name
        return cell!
    }
}

extension SubCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category: ProductCategory = self.subCategory[indexPath.row]
        
        // If Child Categories Count is Greater than 0 and Product List equal to 0, Subcategory Exist
        if category.child_categories.count > 0 && category.productList.count == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubCategoryViewController") as! SubCategoryViewController
            vc.subCategory = CategoryViewModel.sharedInstance.fetchSubCategoryList(category: category)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        // If Child Categories Count is equal to 0 and Product List greater than 0, Product list Exist
        else if category.child_categories.count == 0 && category.productList.count > 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductsListViewController") as! ProductsListViewController
            vc.subCategory = self.subCategory
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
