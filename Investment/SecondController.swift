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
    var dataArray = [GoodsModel]()
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
        

        
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.

        
        
    }
    
    func network() {
        
        
        
        
        ANBaseNetWork.sharedInstance.networkForListNOHUD(.goodsList(page: "\(self.pageflag)"), successHandle: { (result) in
            if self.pageflag == 1 {
                self.dataArray.removeAll()
            }
            for item in result {
                let one = GoodsModel(json: item)
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
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "left", for: indexPath) as! SecondCell
        cell.oneModel = dataArray[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "goodsdetailsegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goodsdetailsegue" {
            let sd = sender as! IndexPath
            let dVC = segue.destination as! GoodsDetailController
            let model = dataArray[sd.section]
            dVC.good_no = model.goodsNo!
            
        }
    }

}
