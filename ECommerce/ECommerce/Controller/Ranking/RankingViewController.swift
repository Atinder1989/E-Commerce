//
//  RankingViewController.swift
//  ECommerce
//
//  Created by Atinderpal Singh on 28/11/17.
//  Copyright © 2017 Abc. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {

    @IBOutlet weak var tableviewRanking: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableviewRanking.tableFooterView = UIView.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension RankingViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryViewModel.sharedInstance.responseVo.rankings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.selectionStyle = .none
        cell?.textLabel?.text = CategoryViewModel.sharedInstance.responseVo.rankings[indexPath.row].ranking
        return cell!
    }
}

extension RankingViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RankingProductListViewController") as! RankingProductListViewController
          vc.productRankList = CategoryViewModel.sharedInstance.responseVo.rankings[indexPath.row].productRankList
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

