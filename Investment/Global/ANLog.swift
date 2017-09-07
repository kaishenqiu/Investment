//
//  ANLog.swift
//  AoNongOA
//

//  Created by zwb on 16/4/5.测试提交
//  Copyright © 2016年 zwb. All rights reserved.
//

import Foundation

func ANLog<T>(_ message: T, fileName: String = #file, methodName: String =  #function, lineNumber: Int = #line) {

    #if DEBUG
        print("\(methodName)[\(lineNumber)]:\(message)")
    #endif

}

func mirror(_ reflecting: Any) {

    let hMirror = Mirror(reflecting: reflecting)
    ANLog("对象类型:\(hMirror.subjectType)")
    ANLog("对象子元素个数:\(hMirror.children.count)")
    ANLog("--- 👇👇👇对象子元素属性名和属性值👇👇👇 ---")
    for case let (label?, value) in hMirror.children {
        ANLog("属性:\(label) 👉👉👉 值:\(value)")
    }
}

func print(_ object:Any) {
    #if DEBUG
        Swift.print(object)
    #endif
}
