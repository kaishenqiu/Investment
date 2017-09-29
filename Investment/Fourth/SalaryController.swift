//
//  SalaryController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/14.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SVProgressHUD

class SalaryController: UIViewController {

    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var balance_fund: UILabel!
    @IBOutlet weak var interest: UILabel!
    @IBOutlet weak var corpus_co: UILabel!
    @IBOutlet weak var interest_co: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ANBaseNetWork.sharedInstance.networkForOriginalWithHeader(.userassert) { (result) in
            
            
            guard let jsonData = result else {
                SVProgressHUD.showInfo(withStatus: "请求失败")
                return
            }
            let flag = jsonData["code"].stringValue
            guard flag == "200" else {
                SVProgressHUD.showInfo(withStatus: "请求失败")
                return
            }
            
            print(jsonData["data"])
            
            self.balance.text = jsonData["data"]["balance"].stringValue
            self.balance_fund.text = jsonData["data"]["balance_fund"].stringValue
            self.interest.text = jsonData["data"]["interest"].stringValue
            self.interest_co.text = jsonData["data"]["interest_co"].stringValue
            self.corpus_co.text = jsonData["data"]["corpus_co"].stringValue
//            let one = GoodsModel(json: jsonData["data"])
//            self.goods_name.text = one.goodsName!
//            
//            let properties = jsonData["data"]["properties"].arrayValue
//            for item in properties {
//                let one = PartModel(json:item)
//                self.partArray.append(one)
//            }
//            
//            print(self.partArray)
//            
//            let properties_group = jsonData["data"]["properties_group"].arrayValue
//            for dic in properties_group {
//                if dic["group_name"] == "部位" {
//                    self.groupArray = dic["list"].arrayObject as! [String]
//                    
//                }
//            }
//       
//            
            
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
