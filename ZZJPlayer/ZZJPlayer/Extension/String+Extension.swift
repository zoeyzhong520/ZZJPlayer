//
//  String+Extension.swift
//  ZZJPlayer
//
//  Created by ZHONG ZHAOJUN on 2018/4/22.
//  Copyright © 2018年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

extension String {
    
    ///获取路径的文件名
    func fileNameForPath() -> String? {
        
        let result = (self as NSString).lastPathComponent
        return (result as NSString).deletingPathExtension
    }
}









