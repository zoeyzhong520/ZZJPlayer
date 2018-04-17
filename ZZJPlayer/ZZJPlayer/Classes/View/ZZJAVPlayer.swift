//
//  ZZJAVPlayer.swift
//  ZZJPlayer
//
//  Created by ZHONG ZHAOJUN on 2018/2/26.
//  Copyright © 2018年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit
import AVFoundation

class ZZJAVPlayer: UIView {

    ///代理
    weak var delegate: ZZJAVPlayerDelegate?
    
    ///视频总长度
    fileprivate var totalTime: TimeInterval!

    ///缓存数据
    fileprivate var loadRange: TimeInterval!
    
    ///播放器
    fileprivate var player: AVPlayer!
    
    ///视频资源
    fileprivate var currentItem: AVPlayerItem!
    
    ///播放器观察者
    fileprivate var timeObser: Any!
    
    ///拖动进度条的时候停止刷新数据
    fileprivate var isSeeking: Bool!
    
    ///是否需要缓冲
    fileprivate var isCanPlay: Bool!
    
    ///是否需要缓冲
    fileprivate var needBuffer: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZZJAVPlayer {
    
    //MARK: UI
    
    fileprivate func createView() {
        
        self.backgroundColor = RGB(244, 244, 244)
        self.isSeeking = false
        self.isCanPlay = false
        self.needBuffer = false
        
        /**
         * 这里view用来做AVPlayer的容器
         * 完成对AVPlayer的二次封装
         * 要求 :
         * 1. 暴露视频输出的API  视频时长 当前播放时间 进度
         * 2. 暴露出易于控制的data入口  播放 暂停 进度拖动 音量 亮度 清晰度调节
         */
        
    }
}

extension ZZJAVPlayer {
    
    //MARK: 属性和方法
    
    ///PlayerTotalTime
    func playerTotalTime() -> TimeInterval {
        
        guard let duration = self.player.currentItem?.duration else { return 0 }
        return CMTimeGetSeconds(duration)
    }
    
    ///准备播放器
    /// - Parameters:
    ///   - videoURL: 视频地址
    func setupPlayerWith(videoURL: String) {
        
        
    }
    
    
}

extension ZZJAVPlayer {
    
    //MARK: 创建播放器
    
    ///获取播放item
    /// - Parameters:
    ///   - videoURL: 视频网址
    ///   - URLType: 网址类型
    func getPlayerItem(videoURL: String, URLType: VariousEnums.URLType) -> AVPlayerItem {
        
        var url: URL!
        
        switch URLType {
        case .Local:
            url = URL(fileURLWithPath: videoURL)
        case .Net:
            url = URL(string: videoURL)
        }
        
        let item = AVPlayerItem(url: url)
        return item
    }
    
    ///创建播放器
    /// - Parameters:
    ///   - videoURL: 视频网址
    ///   - URLType: 网址类型
    func creatPlayer(videoURL: String, URLType: VariousEnums.URLType) {
        
        
    }
    
    /**
     创建播放器 layer 层
     AVPlayerLayer的videoGravity属性设置
     AVLayerVideoGravityResize,       // 非均匀模式。两个维度完全填充至整个视图区域
     AVLayerVideoGravityResizeAspect,  // 等比例填充，直到一个维度到达区域边界
     AVLayerVideoGravityResizeAspectFill, // 等比例填充，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
     */
    func creatPlayerLayer() {
        
        let layer = AVPlayerLayer(player: self.player)
        layer.frame = self.bounds
        layer.videoGravity = .resizeAspect
        self.layer.addSublayer(layer)
    }
    
}

extension ZZJAVPlayer {
    
    //MARK: 添加 监控
    
    ///给player 添加 time observer
    func addPlayerObserver() {
        
        self.timeObser = self.player.addPeriodicTimeObserver(forInterval: CMTimeMake(Int64(1.0), Int32(1.0)), queue: DispatchQueue.main, using: { (time) in
            
            let playerItem = self.player.currentItem
            
            let current = CMTimeGetSeconds(time)
            
            guard let duration = playerItem?.duration else {
                print("duration is nil")
                return
            }
            let total = CMTimeGetSeconds(duration)
            
            if self.isSeeking {
                return
            }
            
            if self.delegate != nil {
                self.delegate?.refreshDataWith!(totalTime: total, currentTime: current, loadTime: self.loadRange)
            }
            
            print("当前播放进度：\(current / total)")
        })
    }
}













