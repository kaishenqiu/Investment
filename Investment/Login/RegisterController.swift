//
//  RegisterController.swift
//  ZYXiangTu
//
//  Created by 邱仙凯 on 2017/2/20.
//  Copyright © 2017年 邱仙凯. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegisterController: UIViewController {

    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var pwdTF: UITextField!

    @IBOutlet weak var countdownBtn: STCountDownButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        countdownBtn.setTitle("second秒", for: .disabled)
  
        
    }
    @IBAction func countDownAction(_ sender: STCountDownButton) {
  
        
        

        guard isTelNumber(num: self.usernameTF.text!) else {
            SVProgressHUD.showError(withStatus: "请输入正确手机号")
            return
        }
   
        SMSSDK.getVerificationCode(by: SMSGetCodeMethodSMS, phoneNumber: self.usernameTF.text!, zone: "86") { (error) in
            

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerClick(_ sender: Any) {
        

        // 数字判断
        guard
            let password = pwdTF.text, password.characters.count > 0 else {
                SVProgressHUD.showError(withStatus: "请输入密码")
                return
        }

        ANBaseNetWork.sharedInstance.networkForBool(.register(mobile: self.usernameTF.text!, password: self.pwdTF.text!, code: self.phoneTF.text!), successHandle: { (result) in
            SVProgressHUD.showInfo(withStatus: "注册成功")
            self.navigationController!.popViewController(animated: true)
 
            
        }, errorHandle: { (error) in
            SVProgressHUD.showInfo(withStatus: error)
        })

    }

}
