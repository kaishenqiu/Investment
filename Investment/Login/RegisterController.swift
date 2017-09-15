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

    @IBOutlet weak var countdownBtn: SwiftCountdownButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        countdownBtn.setTitle("second秒", for: .disabled)
  
        
    }
    @IBAction func countDownAction(_ sender: Any) {
//        countdownBtn.countdown = true
        
        SMSSDK.getVerificationCode(by: SMSGetCodeMethodSMS, phoneNumber: "17706019256", zone: "86") { (error) in
            if (error != nil)
            {
                // 请求成功
                SVProgressHUD.showSuccess(withStatus: "发送成功")
            }
            else
            {
                // error
                SVProgressHUD.showError(withStatus: "发送失败")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerClick(_ sender: Any) {
        


        
//        
//        if pwdTF.text != checkPwdTF.text {
//            SVProgressHUD.showError(withStatus: "两次密码不相同")
//            return
//        }
//        // 数字判断
//        guard let phoneNum = phoneTF.text, phoneNum.characters.count > 0,
//            let password = pwdTF.text, password.characters.count > 0,
//            let personname = usernameTF.text, personname.characters.count > 0 else {
//                SVProgressHUD.showError(withStatus: "打*号为必填项")
//                return
//        }

        ANBaseNetWork.sharedInstance.networkForBool(.register(mobile: "17706019256", password: "123456", code: self.pwdTF.text!), successHandle: { (result) in
            SVProgressHUD.showInfo(withStatus: "注册成功")
 
            
        }, errorHandle: { (error) in
            SVProgressHUD.showInfo(withStatus: error)
        })

    }

}
