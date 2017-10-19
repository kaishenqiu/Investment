//
//  BaseNavController.swift
//  PigManager
//
//  Created by 邱仙凯 on 2017/8/22.
//  Copyright © 2017年 Much. All rights reserved.
//

import UIKit

class BaseNavController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(getImageWithColor(color: GlobalColor, size: CGSize(width:1,height:1)), for: .any, barMetrics: .default)
        interactivePopGestureRecognizer?.delegate = self
        // Do any additional setup after loading the view.
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            let backButton = UIButton(type: .custom)
            backButton.frame.size = CGSize(width: 20, height: 20)
            backButton.contentEdgeInsets = UIEdgeInsetsMake(1, -10 , 1, 15)
            backButton.setImage(UIImage(named:"返回"), for: .normal)
            backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
 

}

// MARK:UIGestureRecognizerDelegate
extension BaseNavController {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return childViewControllers.count > 1
    }
}

extension BaseNavController {
    func back() {
        popViewController(animated: true)
    }
}

