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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ZZJAVPlayerSubViewController {
    
    //MARK: UI
    
    fileprivate func setPage() {
        
        self.title = "根视图"
        self.addSubView()
    }
    
    ///addSubView
    fileprivate func addSubView() {
        
        self.view.addSubview(self.subView)
        self.subView.model = ZZJAVPlayerModel.configModel(localVideoURLArray: ["笑一笑 ~シャオイーシャオ!~ -- ももいろクローバーZ", "トキトキメキメキ"], netVideoURLArray: [TestVideoURL])
    }
}

extension ZZJAVPlayerSubViewController: ZZJAVPlayerSubViewDelegate {
    
    func selectCellWith(index: Int, URLType: Int) {
        
        if URLType == VariousEnums.URLType.Local.rawValue {//本地文件
            
        } else {//网络视频
            
        }
    }
}












