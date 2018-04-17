//
//  ZZJPlayerHomeViewController.swift
//  ZZJPlayer
//
//  Created by JOE on 2018/4/17.
//  Copyright © 2018年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class ZZJPlayerHomeViewController: ZZJPlayerBaseViewController {

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

extension ZZJPlayerHomeViewController {
    
    //MARK: UI
    
    fileprivate func setPage() {
        
        self.title = "首页"
    }
}










