//
//  BaseTabbarController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/7/12.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit

class BaseTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //设置tabbar的文字属性
        setUpTabbarItemTextArrtibutes()
        
        //添加子控制器
        setUpChildController(vc:  UIStoryboard.init(name: "First", bundle: nil).instantiateInitialViewController()!, title: "首页", image: #imageLiteral(resourceName: "fangy-30"), selectedImage: #imageLiteral(resourceName: "fangy-30"))
        setUpChildController(vc: UIStoryboard.init(name: "Second", bundle: nil).instantiateInitialViewController()!, title: "地图", image: #imageLiteral(resourceName: "fangy-30"), selectedImage: #imageLiteral(resourceName: "fangy-30"))
        setUpChildController(vc: UIStoryboard.init(name: "Third", bundle: nil).instantiateInitialViewController()!, title: "政策", image: #imageLiteral(resourceName: "fangy-30"), selectedImage: #imageLiteral(resourceName: "fangy-30"))
        setUpChildController(vc: UIStoryboard.init(name: "Fourth", bundle: nil).instantiateInitialViewController()!, title: "我", image: #imageLiteral(resourceName: "fangy-30"), selectedImage: #imageLiteral(resourceName: "fangy-30"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}

// MARK:设置tabbar
extension BaseTabbarController {
    // MARK:设置item的文字属性
    fileprivate func setUpTabbarItemTextArrtibutes() {
        let item = UITabBarItem.appearance()
        //普通状态下
        var normalAttrs = [String : Any]()
        normalAttrs[NSForegroundColorAttributeName] = UIColor.init(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 1)
        item.setTitleTextAttributes(normalAttrs, for: .normal)
        //选中状态下的文字
        var selectAttrs = [String : Any]()
        selectAttrs[NSForegroundColorAttributeName] = #colorLiteral(red: 0.09803921569, green: 0.6, blue: 0.9137254902, alpha: 1)
        item.setTitleTextAttributes(selectAttrs, for: .selected)
    }
    
    // MARK:初始化子控制器
    fileprivate func setUpChildController(vc: UIViewController, title: String, image: UIImage, selectedImage: UIImage) {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        addChildViewController(vc)
    }
    
    
}
