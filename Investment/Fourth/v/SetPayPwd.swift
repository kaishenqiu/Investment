//
//  SetPayPwd.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/23.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SVProgressHUD

class SetPayPwd: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var pwdLab: UITextField!
    @IBOutlet weak var codeLab: UITextField!
    @IBAction func getcodeAction(_ sender: STCountDownButton) {
        
 
        SMSSDK.getVerificationCode(by: SMSGetCodeMethodSMS, phoneNumber: UserDefaults.standard.value(forKey: LOGINNAME) as! String!, zone: "86") { (error) in
            
            
            sender.isEnabled = false
            sender.starCountDownWithSeconf(secondCount: 60)
            sender.countChanging { (countBtn, second) -> (String) in
                return "\(second)秒"
            }
            
        }
        
        //结束
        sender.countFinish { (countBtn, sencond) -> (String) in
            countBtn.isEnabled = true
            return "重新获取"
        }
        
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        
        ANBaseNetWork.sharedInstance.networkForBoolWithHeader(.setpaypwd(pay_pwd: self.pwdLab.text!, mobile: UserDefaults.standard.value(forKey: LOGINNAME) as! String!, code: self.codeLab.text!), successHandle: { (result) in
            SVProgressHUD.showInfo(withStatus: "设置成功")
            self.removeFromSuperview()
            
            
        }, errorHandle: { (error) in
            SVProgressHUD.showInfo(withStatus: error)
        })

        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    

}
