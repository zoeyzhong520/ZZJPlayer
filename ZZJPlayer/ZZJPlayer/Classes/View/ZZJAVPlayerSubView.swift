//
//  ZZJAVPlayerSubView.swift
//  ZZJPlayer
//
//  Created by JOE on 2018/4/17.
//  Copyright © 2018年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class ZZJAVPlayerSubView: UIView {

    ///UITableView
    fileprivate var tableView: UITableView!
    
    ///model
    var model: ZZJAVPlayerModel? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    ///代理
    weak var delegate: ZZJAVPlayerSubViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ZZJAVPlayerSubView {
    
    //MARK: UI
    
    fileprivate func createView() {
        
        self.backgroundColor = UIColor.white
        self.addTableView()
    }
    
    ///addTableView
    fileprivate func addTableView() {
        
        self.tableView = UITableView(frame: self.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.register(ZZJAVPlayerSubViewTableViewCell.self, forCellReuseIdentifier: VariousCellIds.ZZJAVPlayerSubViewTableViewCellId.ZZJAVPlayerSubViewTableViewCellId)
        self.addSubview(tableView)
    }
}

extension ZZJAVPlayerSubView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "本地文件"
        } else {
            return "网络视频"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            guard let localCnt = self.model?.localVideoURLArray?.count else {
                print("localVideoURLArray is nil")
                return 0
            }
            return localCnt
        } else {
            guard let netCnt = self.model?.netVideoURLArray?.count else {
                print("netVideoURLArray is nil")
                return 0
            }
            return netCnt
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var titleStr:String?
        if indexPath.section == 0 {
            titleStr = self.model?.localVideoURLArray?[indexPath.row]
        } else {
            titleStr = self.model?.netVideoURLArray?[indexPath.row]
        }
        
        let cell = ZZJAVPlayerSubViewTableViewCell.createCellFor(tableView: tableView, AtIndexPath: indexPath, titleStr: titleStr)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let URLType = indexPath.section == 0 ? VariousEnums.URLType.Local.rawValue : VariousEnums.URLType.Net.rawValue
        
        if self.delegate != nil {
            self.delegate?.selectCellWith!(index: indexPath.row, URLType: URLType) //调用代理方法
        }
    }
}
















