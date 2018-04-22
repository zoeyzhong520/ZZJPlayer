//
//  ZZJAVPlayerSubViewTableViewCell.swift
//  ZZJPlayer
//
//  Created by JOE on 2018/4/17.
//  Copyright © 2018年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class ZZJAVPlayerSubViewTableViewCell: UITableViewCell {

    var titleStr: String? {
        didSet {
            self.showData()
        }
    }
    
    fileprivate func showData() {
        
        //去重
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: self.contentView.bounds.size.width - 20*2, height: self.contentView.bounds.size.height))
        titleLabel.text = self.titleStr
        titleLabel.textAlignment = .left
        titleLabel.font = zzj_SystemFontWithSize(14)
        self.contentView.addSubview(titleLabel)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ZZJAVPlayerSubViewTableViewCell {
    
    ///构造cell的方法
    class func createCellFor(tableView: UITableView, AtIndexPath indexPath: IndexPath, titleStr: String?) -> ZZJAVPlayerSubViewTableViewCell {
        
        let cellId = VariousCellIds.ZZJAVPlayerSubViewTableViewCellId.ZZJAVPlayerSubViewTableViewCellId
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ZZJAVPlayerSubViewTableViewCell
        if cell == nil {
            print("cell 创建失败")
        }
        cell?.titleStr = titleStr
        return cell!
    }
}











