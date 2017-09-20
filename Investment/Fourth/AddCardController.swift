//
//  AddCardController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/18.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddCardController: UIViewController {

    @IBOutlet weak var account_nm: UITextField!
    @IBOutlet weak var bank_no: UITextField!
    @IBOutlet weak var bank_nm: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func bindAction(_ sender: Any) {
        
       
        guard let account = account_nm.text, account.characters.count > 0 else {
                SVProgressHUD.showError(withStatus: "请输入账号")
                return
        }
        guard let bankno = bank_no.text, bankno.characters.count > 0 else {
            SVProgressHUD.showError(withStatus: "请输入卡号")
            return
        }
        guard let banknm = bank_nm.text, banknm.characters.count > 0 else {
            SVProgressHUD.showError(withStatus: "请输入开户行")
            return
        }
        
        ANBaseNetWork.sharedInstance.networkForBoolWithHeader(.bindbank(account_nm: account, bank_no: bankno, bank_nm: banknm), successHandle: { (result) in
            SVProgressHUD.showInfo(withStatus: "绑定成功")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: CALL_CARD_REFRESH), object: nil)

            self.navigationController!.popViewController(animated: true)
            
            
        }, errorHandle: { (error) in
            SVProgressHUD.showInfo(withStatus: error)
        })

        
        
        
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
