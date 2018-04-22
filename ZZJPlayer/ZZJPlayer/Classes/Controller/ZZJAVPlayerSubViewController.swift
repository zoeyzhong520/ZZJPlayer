//
//  ZZJPlayerSubViewController.swift
//  ZZJPlayer
//
//  Created by JOE on 2018/4/17.
//  Copyright © 2018年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class ZZJAVPlayerSubViewController: ZZJAVPlayerBaseViewController {

    lazy var subView: ZZJAVPlayerSubView = {
        let subView = ZZJAVPlayerSubView(frame: CGRect(x: 0, y: NavigationBarHeight + StatusBarHeight, width: screenWidth, height: screenHeight - (NavigationBarHeight + StatusBarHeight)))
        subView.delegate = self
        return subView
    }()
    
    ///视频网址
    fileprivate var videoURL:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ZZJAVPlayerSubViewController {
    
    //MARK: UI
    
    fileprivate func setPage() {
        
        self.title = "播放列表"
        self.addSubView()
    }
    
    ///addSubView
    fileprivate func addSubView() {
        
        self.view.addSubview(self.subView)
        
        let bundlePath1 = ZZJAVPlayerSubViewModel.bundlePathWith(forResource: "笑一笑 ~シャオイーシャオ!~ -- ももいろクローバーZ", ofType: "mp4")
        let bundlePath2 = ZZJAVPlayerSubViewModel.bundlePathWith(forResource: "トキトキメキメキ", ofType: "mp4")
        
        self.subView.model = ZZJAVPlayerModel.configModel(localVideoURLArray: [bundlePath1, bundlePath2], netVideoURLArray: [NetVideoURL])
    }
}

extension ZZJAVPlayerSubViewController: ZZJAVPlayerSubViewDelegate {
    
    func selectCellWith(URLType: Int, url: String) {
        
        let vc = ZZJAVPlayerHomeViewController()
        vc.URLType = VariousEnums.URLType(rawValue: URLType)
        vc.url = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
}












