//
//  Protocols.swift
//  ZZJPlayer
//
//  Created by JOE on 2018/4/17.
//  Copyright © 2018年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import Foundation

@objc protocol ZZJAVPlayerDelegate: NSObjectProtocol {
    
    ///数据刷新
    @objc optional func refreshDataWith(totalTime: TimeInterval, currentTime: TimeInterval, loadTime: TimeInterval)
    
    ///状态/错误 提示
    @objc optional func promptPlayerStatusOrErrorWith(status: VariousEnums.ZZJAVPlayerStatus.RawValue)
}

@objc protocol ZZJAVPlayerSubViewDelegate: NSObjectProtocol {
    
    ///点击了cell
    @objc optional func selectCellWith(index: Int, URLType: VariousEnums.URLType.RawValue)
}














