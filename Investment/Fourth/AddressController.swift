//
//  AddressController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/20.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SVProgressHUD
class AddressController: UITableViewController {

    var fromChoose = false
    var selectAddrBlock:((AddrModel) -> ())?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
 
        
  
    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return AddressArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddrCell", for: indexPath) as! AddrCell
        let one = AddressArray[indexPath.section]
        cell.oneModel = one
        cell.delBlock = {
            ANBaseNetWork.sharedInstance.networkForBoolWithHeader(.deladdress(id: "\(one.id!)"), successHandle: { (result) in
                SVProgressHUD.showInfo(withStatus: "删除成功")
                getAddressList(netendHandle: {
                    self.tableView.reloadData()
                })

                
            }, errorHandle: { (error) in
                SVProgressHUD.showInfo(withStatus: error)
            })

          
        }
        cell.defauBlock = { str in
            ANBaseNetWork.sharedInstance.networkForBoolWithHeader(.defauaddress(id: "\(one.id!)", defau: str), successHandle: { (result) in
                SVProgressHUD.showInfo(withStatus: "更新成功")
                getAddressList(netendHandle: { 
                    self.tableView.reloadData()
                })
                
            }, errorHandle: { (error) in
                SVProgressHUD.showInfo(withStatus: error)
            })
            
            
        }
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        if fromChoose {
            self.selectAddrBlock!(AddressArray[indexPath.section])
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }

}
