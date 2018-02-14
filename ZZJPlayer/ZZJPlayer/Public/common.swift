//
//  common.swift
//  ZZJPlayer
//
//  Created by JOE on 2018/2/14.
//  Copyright © 2018年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

//MARK: - 判断设备
///iPhone设备
let isIphone = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false)

///iPad设备
let isIpad = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? true : false)

///isIphoneX
let isIphoneX = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 812 ? true : false

///SafeAreaBottomHeight
let SafeAreaBottomHeight = isIphoneX ? 34.0 : 0

//MARK: - 屏幕宽度
///屏幕宽度
let screenWidth = UIScreen.main.bounds.size.width

//MARK: - 屏幕高度
///屏幕高度
let screenHeight = UIScreen.main.bounds.size.height

//MARK: - 状态栏高度
///StatusBarHeight
let StatusBarHeight = UIApplication.shared.statusBarFrame.height

//MARK: - 导航栏高度
///NavigationBarHeight
let NavigationBarHeight = CGFloat(44)

//MARK: - Color
///RGB
let RGB: (CGFloat, CGFloat, CGFloat) -> UIColor = { r,g,b in
    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
}

///RGBA
let RGBA: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = { r,g,b,a in
    return UIColor(red: r, green: g, blue: b, alpha: a)
}

///根据色值生成颜色(无透明度)(格式为0xffffff)
var zzj_ColorWithHex:(NSInteger) -> UIColor = {hex in
    
    let red = ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0
    let green = ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0
    let blue = ((CGFloat)((hex & 0xFF))) / 255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

//MARK: - 常用字体
///系统普通字体
let zzj_SystemFontWithSize: (CGFloat) -> UIFont = { size in
    return UIFont.systemFont(ofSize: size)
}

///系统加粗字体
var zzj_BoldFontWithSize:(CGFloat) -> UIFont = {size in
    return UIFont.boldSystemFont(ofSize: size)
}

///仅用于标题栏上，大标题字号
let navFont = zzj_SystemFontWithSize(18)

///标题字号
let titleFont = zzj_SystemFontWithSize(18)

///正文字号
let bodyFont = zzj_SystemFontWithSize(16)

///辅助字号
let assistFont = zzj_SystemFontWithSize(14)



















