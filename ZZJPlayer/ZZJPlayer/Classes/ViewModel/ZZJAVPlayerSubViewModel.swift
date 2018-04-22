//
//  ZZJAVPlayerSubViewModel.swift
//  ZZJPlayer
//
//  Created by JOE on 2018/4/17.
//  Copyright © 2018年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class ZZJAVPlayerSubViewModel: NSObject {

    ///Bundle Path
    class func bundlePathWith(forResource: String, ofType: String) -> String {
        
        return Bundle.main.path(forResource: forResource, ofType: ofType) ?? ""
    }
    
    ///buildPlayerView
    class func buildPlayerViewWith(frame: CGRect, url: String, URLType: VariousEnums.URLType, view: UIView, object: Any) -> ZZJAVPlayer {
        
        let playView = ZZJAVPlayer(frame: frame)
        playView.delegate = object as? ZZJAVPlayerDelegate
        view.addSubview(playView)
        playView.setupPlayerWith(videoURL: url, URLType: URLType)
        
        return playView
    }
}











