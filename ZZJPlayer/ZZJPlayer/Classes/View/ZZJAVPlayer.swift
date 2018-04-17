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
    
    //MARK: 销毁 release
    
    deinit {
        print("销毁了,\(self.classForCoder)")
        self.removeNotification()
        self.removePlayerObserver()
        guard let item = self.player.currentItem else {
            print("item is nil")
            return
        }
        self.removeObserverWithPlayItem(item: item)
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
    ///   - URLType: 网址类型
    func setupPlayerWith(videoURL: String, URLType: VariousEnums.URLType) {
        
        self.creatPlayer(videoURL: videoURL, URLType: URLType)
        
        self.player.play()
        
        self.useDelegateWith(status: .ZZJAVPlayerStatusLoadingVideo)
    }
    
    /**
     avplayer自身有一个rate属性
     rate ==1.0，表示正在播放；rate == 0.0，暂停；rate == -1.0，播放失败
     */
    
    ///播放
    func play() {
        
        if self.player.rate == 0 {
            self.player.play()
        }
    }
    
    ///暂停
    func pause() {
        
        if self.player.rate == 1.0 {
            self.player.pause()
        }
    }
    
    ///播放|暂停
    func playOrPause(closure: ((Bool) -> Void)) {
        
        if self.player.rate == 0 {
            self.player.play()
            closure(true)
        } else if self.player.rate == 1.0 {
            self.player.pause()
            closure(false)
        } else {
            print("播放器出错")
        }
    }
    
    ///拖动视频进度
    func seekPlayerTimeTo(time: TimeInterval) {
        
        self.pause()
        
        self.startToSeek()
        
        self.player.seek(to: CMTimeMake(Int64(time), Int32(1.0))) { (finished) in
            self.endSeek()
            self.play()
        }
    }
    
    ///跳动中不监听
    func startToSeek() {
        
        self.isSeeking = true
    }
    
    func endSeek() {
        
        self.isSeeking = false
    }
    
    ///切换视频
    /// - Parameters:
    ///   - videoURL: 视频网址
    ///   - URLType: 网址类型
    func replacePalyerItem(videoURL: String, URLType: VariousEnums.URLType) {
        
        self.isCanPlay = false
        
        self.pause()
        
        self.removeNotification()
        self.removeObserverWithPlayItem(item: self.currentItem)
        
        self.currentItem = self.getPlayerItem(videoURL: videoURL, URLType: URLType)
        self.player.replaceCurrentItem(with: self.currentItem)
        self.addObserverWithPlayItem(item: self.currentItem)
        self.addNotificatonForPlayer()
        
        self.play()
    }
    
    ///播放状态代理调用
    func useDelegateWith(status: VariousEnums.ZZJAVPlayerStatus) {
        
        if self.isCanPlay == false {
            return
        }
        
        if self.delegate != nil {
            
            self.delegate?.promptPlayerStatusOrErrorWith!(status: status.rawValue)
        }
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
        
        if self.player == nil {
            
            self.currentItem = self.getPlayerItem(videoURL: videoURL, URLType: URLType)
            
            self.player = AVPlayer(playerItem: self.currentItem)
            
            self.creatPlayerLayer()
            
            self.addPlayerObserver()
            
            self.addObserverWithPlayItem(item: self.currentItem)
            
            self.addNotificatonForPlayer()
        }
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
    
    ///移除 time observer
    func removePlayerObserver() {
        
        self.player.removeTimeObserver(self.timeObser)
    }
    
    /** 给当前播放的item 添加观察者
     
     需要监听的字段和状态
     status :  AVPlayerItemStatusUnknown,AVPlayerItemStatusReadyToPlay,AVPlayerItemStatusFailed
     loadedTimeRanges  :  缓冲进度
     playbackBufferEmpty : seekToTime后，缓冲数据为空，而且有效时间内数据无法补充，播放失败
     playbackLikelyToKeepUp : seekToTime后,可以正常播放，相当于readyToPlay，一般拖动滑竿菊花转，到了这个这个状态菊花隐藏
     
     */
    func addObserverWithPlayItem(item: AVPlayerItem) {
        
        item.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        item.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        item.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        item.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
    }
    
    ///移除 item 的 observer
    func removeObserverWithPlayItem(item: AVPlayerItem) {
        
        item.removeObserver(self, forKeyPath: "status")
        item.removeObserver(self, forKeyPath: "loadedTimeRanges")
        item.removeObserver(self, forKeyPath: "playbackBufferEmpty")
        item.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
    }
    
    ///数据处理 获取到观察到的数据 并进行处理
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let item = object as? AVPlayerItem else {
            print("item is nil")
            return
        }
        
        if keyPath == "status" {// 播放状态
            self.handleStatusWithPlayerItem(item: item)
        } else if keyPath == "loadedTimeRanges" {// 缓冲进度
            self.handleLoadedTimeRangesWithPlayerItem(item: item)
        } else if keyPath == "playbackBufferEmpty" {// 跳转后没数据
            // 转菊花
            if self.isCanPlay {
                print("跳转后没数据")
                self.needBuffer = true
                self.useDelegateWith(status: .ZZJAVPlayerStatusCacheData)
            }
        } else if keyPath == "playbackLikelyToKeepUp" {// 跳转后有数据
            // 隐藏菊花
            if self.isCanPlay && self.needBuffer {
                print("跳转后有数据")
                self.needBuffer = false
                self.useDelegateWith(status: .ZZJAVPlayerStatusCacheEnd)
            }
        }
    }
    
    /**
     处理 AVPlayerItem 播放状态
     AVPlayerItemStatusUnknown           状态未知
     AVPlayerItemStatusReadyToPlay       准备好播放
     AVPlayerItemStatusFailed            播放出错
     */
    func handleStatusWithPlayerItem(item: AVPlayerItem) {
        
        switch item.status {
        case .readyToPlay: // 准备好播放
            print("readyToPlay")
            self.isCanPlay = true
            self.useDelegateWith(status: .ZZJAVPlayerStatusReadyToPlay)
        case .failed: // 播放出错
            print("failed")
            self.useDelegateWith(status: .ZZJAVPlayerStatusItemFailed)
        case .unknown:
            print("unknown") // 状态未知
        }
    }
    
    ///处理缓冲进度
    func handleLoadedTimeRangesWithPlayerItem(item: AVPlayerItem) {
        
        let loadArray = item.loadedTimeRanges
        
        guard let range = loadArray.first as? CMTimeRange else {
            print("range is nil")
            return
        }
        
        let start = CMTimeGetSeconds(range.start)
        
        let duration = CMTimeGetSeconds(range.duration)
        
        let totalTime = start + duration // 缓存总长度
        
        self.loadRange = totalTime
        print("缓冲进度：\(totalTime)")
    }
    
    /**
     添加关键通知
     
     AVPlayerItemDidPlayToEndTimeNotification     视频播放结束通知
     AVPlayerItemTimeJumpedNotification           视频进行跳转通知
     AVPlayerItemPlaybackStalledNotification      视频异常中断通知
     UIApplicationDidEnterBackgroundNotification  进入后台
     UIApplicationDidBecomeActiveNotification     返回前台
     
     */
    func addNotificatonForPlayer() {
        
        let center = NotificationCenter.default
        
        center.addObserver(self, selector: #selector(videoPlayEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        center.addObserver(self, selector: #selector(videoPlayError), name: NSNotification.Name.AVPlayerItemPlaybackStalled, object: nil)
        center.addObserver(self, selector: #selector(videoPlayEnterBack), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        center.addObserver(self, selector: #selector(videoPlayBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    ///移除 通知
    func removeNotification() {
        
        let center = NotificationCenter.default
        
        center.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        center.removeObserver(self, name: NSNotification.Name.AVPlayerItemPlaybackStalled, object: nil)
        center.removeObserver(self, name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        center.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    ///视频播放结束
    @objc func videoPlayEnd() {
        
        print("视频播放结束")
        
        self.useDelegateWith(status: .ZZJAVPlayerStatusPlayEnd)
        self.player.seek(to: kCMTimeZero)
    }
    
    ///视频异常中断
    @objc func videoPlayError() {
        
        print("视频异常中断")
        
        self.useDelegateWith(status: .ZZJAVPlayerStatusPlayStop)
    }
    
    ///进入后台
    @objc func videoPlayEnterBack() {
        
        print("进入后台")
        
        self.useDelegateWith(status: .ZZJAVPlayerStatusEnterBack)
    }
    
    ///返回前台
    @objc func videoPlayBecomeActive() {
        
        print("返回前台")
        
        self.useDelegateWith(status: .ZZJAVPlayerStatusBecomActive)
    }
}













