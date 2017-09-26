//
//  LeftDetailController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/15.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SVProgressHUD

class LeftDetailController: UIViewController {
    var number = ""

    var idn = ""
    @IBOutlet weak var moneyField: UITextField!
    var passwordView:CYPasswordView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
            
        ANBaseNetWork.sharedInstance.networkForOriginal(.projectinfo(no: number)) { (result) in
            
            
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
//            self.goods_name.text = one.goodsName!
            self.idn = one.id!
            print(jsonData["data"])
            
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func investAction(_ sender: Any) {
        
        
        // 数字判断
        guard let money = moneyField.text, money.characters.count > 0 else {
                SVProgressHUD.showError(withStatus: "请输入金额")
                return
        }
        
        
        
        passwordView = CYPasswordView()
        passwordView.title = "输入交易密码"
        passwordView.loadingText = "提交中..."
        passwordView.show(in: self.view.window)
        passwordView.finish = { password in
            self.passwordView.hideKeyboard()
            self.passwordView.startLoading()
            
            
                    ANBaseNetWork.sharedInstance.networkForBoolWithHeader(.projectinvest(pid: self.idn, money: money, pay_pwd: password!), successHandle: { (result) in
                        SVProgressHUD.showInfo(withStatus: "投资成功")
                        self.navigationController!.popViewController(animated: true)
                        self.passwordView.hide()
            
            
                    }, errorHandle: { (error) in
                        SVProgressHUD.showInfo(withStatus: error)
                        self.passwordView.stopLoading()
                    })
        
        }
        
        
 
        
        


        
    }
    @IBAction func recordAction(_ sender: Any) {
        self.performSegue(withIdentifier: "torecord", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "torecord" {
         let deV = segue.destination as! RecordController
            deV.idnum = self.idn
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
