//
//  LoginController.swift
//  ZYXiangTu
//
//  Created by 邱仙凯 on 2017/2/20.
//  Copyright © 2017年 邱仙凯. All rights reserved.
//

import UIKit
import SVProgressHUD
class LoginController: UIViewController {

    @IBOutlet var usernameView: UIView!
    @IBOutlet var passwordView: UIView!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = GlobalColor.cgColor
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func loginAction(_ sender: Any) {
        
        // 数字判断
        guard let phoneNum = mobileField.text, phoneNum.characters.count > 0,
            let password = pwdField.text, password.characters.count > 0 else {
                SVProgressHUD.showError(withStatus: "手机号与密码不能为空")
                return
        }
//        loginVM.loginData(username: phoneNum, password: password, successCallback: {
//            
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Userinforefresh"), object: nil)
//            self.dismiss(animated: true, completion: { 
//                
//            })
//        }) { 
//            
//        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

}
