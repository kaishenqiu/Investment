//
//  MyInvestmentController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/13.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyInvestmentController: UITableViewController {
    var dataArray = [InvestModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

         
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        
        tableView.mj_header = ANRefreshHeader {
            self.network()
        }
        
        
        tableView.mj_header.beginRefreshing()
    }
    func network() {
        
        ANBaseNetWork.sharedInstance.networkForListNOHUDWithHeader(.myinvest, successHandle: { (result) in
            print(result)
            self.dataArray.removeAll()
            for item in result {
                let one = InvestModel(json: item)
                self.dataArray.append(one)
                
            }
            self.tableView.mj_header.endRefreshing()
            
            self.tableView.reloadData()
        }) { (errorStr) in
            self.tableView.mj_header.endRefreshing()
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyInvestmentCell", for: indexPath) as! MyInvestmentCell
        cell.oneModel = dataArray[indexPath.section]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  8
    }

 

}
