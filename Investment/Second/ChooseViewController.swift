//
//  ChooseViewController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/23.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON

class ChooseViewController: UIViewController {
    
    
    @IBOutlet weak var numLab: UILabel!
    @IBOutlet weak var sumMoney: UILabel!
    @IBOutlet weak var partLab: UILabel!
    var oneModel = PartModel(json:JSON.null)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let viewG = UITapGestureRecognizer(target: self, action: #selector(addrAction))
        addrView.addGestureRecognizer(viewG)

        // Do any additional setup after loading the view.
        partLab.text = "部位：" + oneModel.name!
        numLab.text = "数量： \(oneModel.number!)  单价： \(oneModel.wxprice!)"
        let sum = oneModel.number! * Int(oneModel.wxprice!)!
        sumMoney.text = "总价：\(sum) 元"
        
        
    }
    @IBOutlet weak var addrView: UIView!
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addrAction() {
        
        let view = UIStoryboard(name: "Fourth", bundle: Bundle.main).instantiateViewController(withIdentifier: "addresslist")
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func makeOrder(_ sender: Any) {
            var ff = [String:String]()
            ff.updateValue("1", forKey: "number")
            ff.updateValue("SKU10242017091508424142571", forKey: "pno")
        
            print(ff)
        
        
            ANBaseNetWork.sharedInstance.networkForBoolWithHeader(.makeorder(goods_list: "[\'number\':\'1\',\'pno\':\'SKU10242017091508424142571\']", address_id: "2"), successHandle: { (result) in
            SVProgressHUD.showInfo(withStatus: "成功")
        
        
        
            }, errorHandle: { (error) in
            SVProgressHUD.showInfo(withStatus: error)
            })
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
