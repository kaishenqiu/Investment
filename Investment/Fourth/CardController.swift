//
//  CardController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/14.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit

class CardController: UITableViewController {
    
     var dataArray = [CardModel]()

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
        
        ANBaseNetWork.sharedInstance.networkForListNOHUDWithHeader(.mybank, successHandle: { (result) in
            
            self.dataArray.removeAll()
            for item in result {
                let one = CardModel(json: item)
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
        cell.oneModel = dataArray[indexPath.row]
        
        return cell
    }



}
