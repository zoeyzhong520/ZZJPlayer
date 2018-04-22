//
//  ZZJPlayerHomeViewController.swift
//  ZZJPlayer
//
//  Created by JOE on 2018/4/17.
//  Copyright © 2018年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class ZZJAVPlayerHomeViewController: ZZJAVPlayerBaseViewController {

    ///URLType
    var URLType: VariousEnums.URLType?
    
    ///url
    var url: String?
    
    ///playerView
    var playerView: ZZJAVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPage()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.playerView.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ZZJAVPlayerHomeViewController {
    
    //MARK: UI
    
    fileprivate func setPage() {
        
        self.title = self.url?.fileNameForPath()
        
        self.setPlayerView()
    }
    
    fileprivate func setPlayerView() {
        
        self.playerView = ZZJAVPlayerSubViewModel.buildPlayerViewWith(frame: PlayerViewFrame, url: url!, URLType: self.URLType!, view: self.view, object: self)
    }
}










