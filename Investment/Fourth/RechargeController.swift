//
//  RechargeController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/25.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON

class RechargeController: UIViewController {

    @IBOutlet weak var moneyField: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var chooseLab: UILabel!
    @IBOutlet weak var bg: UIView!
    var passwordView:CYPasswordView!
    var cardModel = CardModel(json:JSON.null)
    override func viewDidLoad() {
        super.viewDidLoad()
        img.isHidden = true
        name.isHidden = true
        num.isHidden = true

        // Do any additional setup after loading the view.
        
        let viewG = UITapGestureRecognizer(target: self, action: #selector(chooseCardAction))
        bg.addGestureRecognizer(viewG)
    }
    func chooseCardAction() {
        
        let view = UIStoryboard(name: "Fourth", bundle: Bundle.main).instantiateViewController(withIdentifier: "cardlist") as! CardController
        view.fromChoose = true
        view.selectBlock = { model in
            self.name.isHidden = false
            self.num.isHidden = false
            self.img.isHidden = false
            self.chooseLab.isHidden = true
            self.name.text = model.accountNm
            self.num.text = model.bankNo
            self.cardModel = model
        
        }
        self.navigationController?.pushViewController(view, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func rechargeAction(_ sender: Any) {
        
  
        guard let cardid = self.cardModel.id, cardid.characters.count > 0 else {
            SVProgressHUD.showError(withStatus: "请选择银行卡")
            return
        }
   
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
            
            
            ANBaseNetWork.sharedInstance.networkForBoolWithHeader(.recharge(money:money , bank_id: cardid, pay_pwd: password!), successHandle: { (result) in
                SVProgressHUD.showInfo(withStatus: "充值成功")
                self.navigationController!.popViewController(animated: true)
                self.passwordView.hide()
                
                
            }, errorHandle: { (error) in
                SVProgressHUD.showInfo(withStatus: error)
                self.passwordView.stopLoading()
                self.passwordView.hide()
            })
            
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
