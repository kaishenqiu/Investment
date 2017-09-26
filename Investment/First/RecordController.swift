//
//  RecordController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/16.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit

class RecordController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var idnum = ""
     var dataArray = [RecordModel]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        
        tableView.mj_header = ANRefreshHeader {
            self.network()
        }
        
        
        tableView.mj_header.beginRefreshing()
    }
    func network() {
        
        ANBaseNetWork.sharedInstance.networkForListNOHUDWithHeader(.investlist(id: idnum), successHandle: { (result) in
            
            print(result)
            self.dataArray.removeAll()
            for item in result {
                let one = RecordModel(json: item)
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

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordCell
        cell.oneModel = dataArray[indexPath.row]
        
        return cell
    }
 
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "toleftdetail", sender: indexPath)
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toleftdetail" {
//            
//        }
//    }

}
