//
//  SecondController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/6.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit

class SecondController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        
        
        ANBaseNetWork.sharedInstance.networkForListNOHUD(.goodsList(page: "1"), successHandle: { (result) in
            print(result)
//            for item in result {
//                let one = LeftModel(json: item)
//                self.dataArray.append(one)
//                
//            }
//            //            self.tableView.mj_footer.endRefreshing()
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
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "left", for: indexPath) as! SecondCell

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "goodsdetailsegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goodsdetailsegue" {
        
        }
    }

}
