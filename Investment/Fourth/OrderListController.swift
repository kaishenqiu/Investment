//
//  OrderListController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/7.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SwiftyJSON
import SVProgressHUD

class OrderListController: UITableViewController {
    var dataArray = [OrderModel]()
    var pageflag = 1
    var passwordView:CYPasswordView!
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
        
 
        cell.statusBtn.setTitle(statusGuide[model.status!], for: .normal)
        cell.statusBtn.setTitleColor(statusColorGuide[model.status!]!.toUIColor(), for: .normal)
        cell.statusBtn.layer.masksToBounds = true
        cell.statusBtn.layer.borderWidth = 1
        cell.statusBtn.layer.borderColor = statusColorGuide[model.status!]!.toUIColor().cgColor
        cell.statusBtn.tag = indexPath.section
        ANLog(model.status)
        if model.status! == "0" {
            cell.statusBtn.addTarget(self, action: #selector(payAction(sender:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    func payAction(sender:UIButton) {
        let model = dataArray[sender.tag]
        
        self.passwordView = CYPasswordView()
        self.passwordView.title = "输入交易密码"
        self.passwordView.loadingText = "提交中..."
        self.passwordView.show(in: self.view.window)
        self.passwordView.finish = { password in
            self.passwordView.hideKeyboard()
            self.passwordView.startLoading()
            
            // MARK: - 支付
            ANBaseNetWork.sharedInstance.networkForBoolWithHeader(.goodspay(order_no:model.orderNo!, pay_pwd: password!), successHandle: { (result) in
                
                SVProgressHUD.showInfo(withStatus: "支付成功")
                self.passwordView.hide()
                self.tableView.mj_header.beginRefreshing()
                
                
            }, errorHandle: { (error) in
                SVProgressHUD.showInfo(withStatus: error)
                self.passwordView.stopLoading()
                self.passwordView.hide()
 
                
                
            })
            
        }
        
        
        
    }

}
