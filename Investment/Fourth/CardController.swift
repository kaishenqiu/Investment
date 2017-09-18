//
//  CardController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/14.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit

class CardController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.tableFooterView = UIView()
        
        
        ANBaseNetWork.sharedInstance.networkForListNOHUDWithHeader(.mybank, successHandle: { (result) in
            
            print(result)
            
//            if self.pageflag == 1 {
//                self.dataArray.removeAll()
//            }
//            for item in result {
//                let one = LeftModel(json: item)
//                self.dataArray.append(one)
//                
//            }
//            self.tableView.mj_footer.endRefreshing()
//            self.tableView.mj_header.endRefreshing()
//            self.tableView.reloadData()
        }) { (errorStr) in
//            self.tableView.mj_footer.endRefreshing()
//            self.tableView.mj_header.endRefreshing()
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
        
        return cell
    }



}
