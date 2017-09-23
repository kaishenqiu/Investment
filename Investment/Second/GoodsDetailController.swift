//
//  GoodsDetailController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/22.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SVProgressHUD

class GoodsDetailController: UIViewController {
    
    var good_no = ""

    var chooseV:ChooseView!
    @IBOutlet weak var goods_name: UILabel!
    @IBOutlet weak var chooseBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        ANBaseNetWork.sharedInstance.networkForOriginalWithHeader(.goodsinfo(goods_no: good_no)) { (result) in
 
            
            guard let jsonData = result else {
                SVProgressHUD.showInfo(withStatus: "请求失败")
                return
            }
            let flag = jsonData["code"].stringValue
            guard flag == "200" else {
                SVProgressHUD.showInfo(withStatus: "请求失败")
                return
            }
            let one = GoodsModel(json: jsonData["data"])
            self.goods_name.text = one.goodsName!
            
            print(jsonData["data"])
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func chooseAction(_ sender: Any) {
        
        self.chooseV = Bundle.main.loadNibNamed("ChooseView", owner: nil, options: nil)!.last as! ChooseView
        self.chooseV.frame = UIApplication.shared.keyWindow!.frame

        self.chooseV.saveBlock = {str in
            self.chooseBtn.setTitle(str, for: .normal)
            
        }
        UIApplication.shared.keyWindow!.addSubview(self.chooseV)
        
        
    }
    @IBAction func makeOrderAction(_ sender: Any) {
        
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
    
    @IBAction func confirmAction(_ sender: Any) {
        self.performSegue(withIdentifier: "tochooseview", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tochooseview" {
//            let sd = sender as! IndexPath
//            let dVC = segue.destination as! ChooseViewController
//       
            
        }
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
