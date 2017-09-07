//
//  LeftController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/6.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit

class LeftController: UITableViewController {
    var dataArray = [LeftModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
 
        tableView.mj_header = ANRefreshHeader {
            self.network()
        }

        tableView.mj_header.beginRefreshing()
        
        
      

    }
    
    func network() {
        
        ANBaseNetWork.sharedInstance.networkForListNOHUD(.projectList(page: "1"), successHandle: { (result) in
            
            for item in result {
                let one = LeftModel(json: item)
                self.dataArray.append(one)

            }
//            self.tableView.mj_footer.endRefreshing()
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
        }) { (errorStr) in
//            self.tableView.mj_footer.endRefreshing()
            self.tableView.mj_header.endRefreshing()
            
        }
        
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftCell", for: indexPath) as! LeftCell
//        cell.oneModel = dataArray[indexPath.row]
 
        return cell
    }


}
