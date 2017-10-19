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
    
    
    @IBOutlet weak var addrdes: UILabel!
    @IBOutlet weak var addrMobile: UILabel!
    @IBOutlet weak var addrName: UILabel!
    @IBOutlet weak var numLab: UILabel!
    @IBOutlet weak var sumMoney: UILabel!
    @IBOutlet weak var partLab: UILabel!
    var passwordView:CYPasswordView!
    var oneModel = PartModel(json:JSON.null)
    var addrid = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in AddressArray {
            if item.defau == "1" {
                self.addrName.text = item.realname!
                self.addrMobile.text = item.mobile!
                self.addrdes.text =  item.province! + item.city! + item.district! + item.address!
                self.addrid = "\(item.id!)"
            }
        }
        
        
        let viewG = UITapGestureRecognizer(target: self, action: #selector(addrAction))
        addrView.addGestureRecognizer(viewG)

        // Do any additional setup after loading the view.
        partLab.text = "部位：" + oneModel.name!
        numLab.text = "数量： \(oneModel.number!)  单价： \(oneModel.wxprice!)"
        let sum = Double(oneModel.number!) * Double(oneModel.wxprice!)!
        sumMoney.text = "总价：\(sum) 元"
        
        
    }
    @IBOutlet weak var addrView: UIView!
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addrAction() {
        
        let view = UIStoryboard(name: "Fourth", bundle: Bundle.main).instantiateViewController(withIdentifier: "addresslist") as! AddressController
        view.fromChoose = true
        view.selectAddrBlock = { one in
            self.addrName.text = one.realname!
            self.addrMobile.text = one.mobile!
            self.addrdes.text =  one.province! + one.city! + one.district! + one.address!
            self.addrid = "\(one.id!)"
        
        }
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func makeOrder(_ sender: Any) {
        
    
        
            ANBaseNetWork.sharedInstance.networkForOriginalWithHeader(.makeorder(goods_listpno: "\(self.oneModel.pno!)", goods_listnumber: "\(self.oneModel.number!)", address_id: self.addrid), resultHandle: { (result) in
                
                guard let jsonData = result else {
                    SVProgressHUD.showInfo(withStatus: "请求失败")
                    return
                }
                let flag = jsonData["code"].stringValue
                guard flag == "200" else {
                    SVProgressHUD.showInfo(withStatus: "请求失败")
                    return
                }
 
                
                
                self.passwordView = CYPasswordView()
                self.passwordView.title = "输入交易密码"
                self.passwordView.loadingText = "提交中..."
               self.passwordView.show(in: self.view.window)
                self.passwordView.finish = { password in
                    self.passwordView.hideKeyboard()
                    self.passwordView.startLoading()
                    
                    // MARK: - 支付
                    ANBaseNetWork.sharedInstance.networkForBoolWithHeader(.goodspay(order_no: jsonData["data"]["order_no"].stringValue, pay_pwd: password!), successHandle: { (result) in
                        
                        SVProgressHUD.showInfo(withStatus: "支付成功")
                        self.navigationController!.popViewController(animated: true)
                        self.passwordView.hide()
                        
                        
                    }, errorHandle: { (error) in
                        SVProgressHUD.showInfo(withStatus: error)
                        self.passwordView.stopLoading()
                        self.passwordView.hide()
                        self.navigationController!.popViewController(animated: true)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: CALL_JUMPTOORDER), object: nil)
                        
                        // MARK: - 跳到我的订单
                        
                        
                    })
                    
                }
       
        
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
