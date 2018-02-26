//
//  VariousEnums.swift
//  ZZJPlayer
//
//  Created by ZHONG ZHAOJUN on 2018/2/26.
//  Copyright © 2018年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class VariousEnums: NSObject {

    ///创建单例
    static let shareInstance = VariousEnums()
    private override init() {}
    
    ///ZZJAVPlayer的多种播放状态 ZZJAVPlayerStatus
    enum ZZJAVPlayerStatus: Int {
        ///准备好播放
        case ZZJAVPlayerStatusReadyToPlay = 0
        ///加载视频
        case ZZJAVPlayerStatusLoadingVideo
        ///播放结束
        case ZZJAVPlayerStatusPlayEnd
        ///缓冲视频
        case ZZJAVPlayerStatusCacheData
        ///缓冲结束
        case ZZJAVPlayerStatusCacheEnd
        ///播放中断（多是没网）
        case ZZJAVPlayerStatusPlayStop
        ///视频资源问题
        case ZZJAVPlayerStatusItemFailed
        ///进入后台
        case ZZJAVPlayerStatusEnterBack
        ///从后台返回
        case ZZJAVPlayerStatusBecomActive
    }
}






















