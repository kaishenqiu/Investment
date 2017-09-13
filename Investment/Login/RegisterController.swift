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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerClick(_ sender: Any) {
        

        
//        SMSSDK.getVerificationCode(by: SMSGetCodeMethodSMS, phoneNumber: "17706019256", zone: "86") { (error) in
//            if (error != nil)
//            {
//                // 请求成功
//            }
//            else
//            {
//                // error
//            }
//        }
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
//        loginVM.userRegister(username: phoneNum, pwd: password, personName: personname, rid: cardNoTF.text!, rpd: cardPwdTF.text!) {
//            SVProgressHUD.showSuccess(withStatus: "注册成功")
//            _ = self.navigationController?.popViewController(animated: true)
//        }
    }

}
