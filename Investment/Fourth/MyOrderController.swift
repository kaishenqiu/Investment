//
//  MyOrderController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/7.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit

class MyOrderController: UIViewController, UIScrollViewDelegate {
    
    //UIScrollView
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        scrollView.frame = CGRect(x: 0, y: 35 + 10, width: self.view.st_width, height: self.view.st_height - 45 - 64)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    //底部的指示器
    fileprivate lazy var indicatorView: UIView = {
        let indicatorView = UIView()
        indicatorView.backgroundColor = GlobalColor
        return indicatorView
    }()
    
    //标题栏
    let titlesView = UIView()
    
    //当前选中的标题按钮
    fileprivate lazy var selectButton: UIButton = {
        let selectButton = UIButton(type: .custom)
        return selectButton
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setUpUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let firstTitleButton = titlesView.subviews[0] as! UIButton
        
        selectButton.isSelected = false
        firstTitleButton.isSelected = true
        selectButton = firstTitleButton
        titleClick(sender: firstTitleButton)
        
    }
    
}
extension MyOrderController {
    func setUpUI() {
        //添加子控制器
        setUpChildViewControllers()
        
        //设置scrollView
        setUpScrollView()
        
        //设置标题栏
        setUpTitlesView()
        
        //添加子控制器的view
        addChildView()
    }
}


extension MyOrderController {
    // MARK:添加子控制器
    fileprivate func setUpChildViewControllers() {
        let storyboard = UIStoryboard(name: "Fourth", bundle: nil)
        let left = storyboard.instantiateViewController(withIdentifier: "OrderListController")
        addChildViewController(left)
        let storyboard2 = UIStoryboard(name: "First", bundle: nil)
        let right = storyboard2.instantiateViewController(withIdentifier: "right")
        addChildViewController(right)
        
        
    }
    
    // MARK:设置背景scrollView
    fileprivate  func setUpScrollView() {
        automaticallyAdjustsScrollViewInsets = false
        scrollView.contentSize = CGSize(width: CGFloat(childViewControllers.count) * UIScreen.main.bounds.width, height: 0)
        view.addSubview(scrollView)
        
        
    }
    
    
    // MARK:设置标题栏
    fileprivate  func setUpTitlesView() {
        titlesView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titlesView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35)
        view.addSubview(titlesView)
        
        //添加标题
        let titles = ["全部","待付款"]
        let count = titles.count
        let titleButtonW = titlesView.frame.size.width / CGFloat(count)
        let titleButtonH = titlesView.frame.size.height
        for i in 0 ..< count {
            let titleButton = UIButton()
            titleButton.tag = i
            titleButton.setTitleColor(#colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1), for: .normal)
            titleButton.setTitleColor(GlobalColor, for: .selected)
            titleButton.addTarget(self, action: #selector(titleClick), for: .touchUpInside)
            titlesView.addSubview(titleButton)
            titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            titleButton.setTitle(titles[i], for: .normal)
            titleButton.frame = CGRect(x: CGFloat(i) * titleButtonW, y: 0, width: titleButtonW, height: titleButtonH)
        }
        let firstTitleButton = titlesView.subviews.first as! UIButton
        
        
        indicatorView.st_height = 3
        indicatorView.st_y = titlesView.st_height - indicatorView.st_height
        indicatorView.st_width = firstTitleButton.st_width / 2
        indicatorView.st_centerX = firstTitleButton.st_centerX
        
        titlesView.addSubview(indicatorView)
    }
    
    
    //添加子控制器的view
    fileprivate func addChildView() {
        let index: CGFloat = scrollView.contentOffset.x / scrollView.st_width
        
        //取出子控制器
        let childVc = childViewControllers[Int(index)]
        if childVc.isViewLoaded {
            return
        }
        
        childVc.view.frame = scrollView.bounds
        scrollView.addSubview(childVc.view)
    }
    
    func titleClick(sender: UIButton) -> () {
        //按钮状态
        selectButton.isSelected = false
        sender.isSelected = true
        selectButton = sender
        //指示器
        UIView.animate(withDuration: 0.25) {
            self.indicatorView.st_width = sender.st_width / 2
            self.indicatorView.st_centerX = sender.st_centerX
        }
        var offset = scrollView.contentOffset
        offset.x = CGFloat(sender.tag) * scrollView.st_width
        scrollView.setContentOffset(offset, animated: true)
    }
}

extension MyOrderController {
    // MARK:UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        addChildView()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.frame.width
        let titleButton: UIButton = titlesView.subviews[Int(index)] as! UIButton
        titleClick(sender: titleButton)
        addChildView()
        
    }
}
