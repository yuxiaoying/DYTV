//
//  MainViewControl.swift
//  DYTV
//
//  Created by 寂惺 on 2018/6/28.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit

class MainViewControl: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc(storyBoardName :"Home")
        addChildVc(storyBoardName :"Live")
        addChildVc(storyBoardName :"Follow")
        addChildVc(storyBoardName :"Profile")
        // Do any additional setup after loading the view.
    }
    
    private func addChildVc(storyBoardName : String){
        let childVc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVc)
    }

}
