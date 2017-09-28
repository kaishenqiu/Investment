//
//  OrderListController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/7.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrderListController: UITableViewController {
    var dataArray = [OrderModel]()
    var pageflag = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.mj_header = ANRefreshHeader {
            self.pageflag = 1
            self.network()
        }
        tableView.mj_footer = ANRefreshFooter {
            self.pageflag += 1
            self.network()
        }
        
        tableView.mj_header.beginRefreshing()
        tableView.tableFooterView = UIView()
        
        tableView.separatorStyle = .none
        
        
    }
    func network() {
        
        ANBaseNetWork.sharedInstance.networkForListNOHUDWithHeader(.myorder(page: "\(self.pageflag)"), successHandle: { (result) in
            
            if self.pageflag == 1 {
                self.dataArray.removeAll()
            }
            for item in result {
                let one = OrderModel(json: item)
                self.dataArray.append(one)
                
            }
            self.tableView.mj_footer.endRefreshing()
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
        }) { (errorStr) in
            self.tableView.mj_footer.endRefreshing()
            self.tableView.mj_header.endRefreshing()
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell

        
        let model = dataArray[indexPath.section]
        let one = model.goodsitems![0]
        cell.titleLab.text = one["goods_name"] as? String
        cell.priceLab.text = "单价：\(one["price"]!)"
        cell.numLab.text = "数量：\(one["number"]!)"
        
        
        let dist = model.distribution! as! [String:Any]
        cell.statusBtn.setTitle(statusGuide["\(dist["status"]!)"], for: .normal)
        
        
        return cell
    }

}
