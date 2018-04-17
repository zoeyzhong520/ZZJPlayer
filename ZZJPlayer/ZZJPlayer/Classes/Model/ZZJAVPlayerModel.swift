//
//  ZZJAVPlayerModel.swift
//  ZZJPlayer
//
//  Created by ZHONG ZHAOJUN on 2018/2/19.
//  Copyright © 2018年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class ZZJAVPlayerModel: NSObject {

    var localVideoURLArray:Array<String?>?
    var netVideoURLArray:Array<String?>?
    
    ///构造 model
    class func configModel(localVideoURLArray: [String?], netVideoURLArray: [String?]) -> ZZJAVPlayerModel {
        
        let model = ZZJAVPlayerModel()
        model.localVideoURLArray = localVideoURLArray
        model.netVideoURLArray = netVideoURLArray
        return model
    }
}
