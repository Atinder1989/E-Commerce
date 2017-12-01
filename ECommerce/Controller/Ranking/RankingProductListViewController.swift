//
//  RankingListViewController.swift
//  ECommerce
//
//  Created by Atinderpal Singh on 01/12/17.
//  Copyright © 2017 Abc. All rights reserved.
//

import UIKit

class RankingProductListViewController: UIViewController {
    var productRankList = [ProductRank]()
    
    @IBOutlet weak var productRankListTableView:    UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.productRankListTableView.tableFooterView = UIView.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}

// MARK:- UITableview DataSource
extension RankingProductListViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productRankList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: ProductRankListCell.identifier) as! ProductRankListCell
        cell.selectionStyle = .none
        let productRank: ProductRank = self.productRankList[indexPath.row]
        cell.countLabel.text = "Count = \(String(productRank.view_count!))"
        let productName = DatabaseManager.sharedInstance.getProductName(with: productRank.id)
        cell.nameLabel.text  = "Name = \(productName)"
        return cell
    }
}

