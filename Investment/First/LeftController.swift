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
        
        ANBaseNetWork.sharedInstance.networkForListNOHUD(.projectList(page: "\(self.pageflag)"), successHandle: { (result) in
            
            if self.pageflag == 1 {
            self.dataArray.removeAll()
            }
            for item in result {
                let one = LeftModel(json: item)
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftCell", for: indexPath) as! LeftCell
        cell.oneModel = dataArray[indexPath.section]
 
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toleftdetail", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toleftdetail" {
            let sd = sender as! IndexPath
            let dVC = segue.destination as! LeftDetailController
            let model = dataArray[sd.section]
            dVC.number = model.no!
        
        }
    }

}
