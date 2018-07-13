//
//  HomeViewController.swift
//  DYTV
//
//  Created by 寂惺 on 2018/6/28.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //懒加载属性
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: KScreenW, height: kTitleViewH)
        let titles:[String] = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
//        titleView.backgroundColor = UIColor.lightGray
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = { [weak self] in
        let contentFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH+kTitleViewH, width: KScreenW, height: kContentViewH)
        var childVcs = [UIViewController]()
        childVcs.append(RecommandViewController())
        for index in 0...2{
            let childVc = UIViewController()
            childVc.view.backgroundColor = UIColor(r: arc4random_uniform(255), g: arc4random_uniform(255), b: arc4random_uniform(255))
            childVcs.append(childVc)
        }
        let pageContentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    

}


//设置UI
extension HomeViewController{
    private func setupUI(){
        //设置导航栏
        setupNavigationBar()
        
        //添加titleView
        view.addSubview(pageTitleView)
        
        //添加pageContentView
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBar(){
        //设置左侧logo
//        let btn = UIButton()
//        btn.setImage(UIImage(named: "logo"), for: .normal)
//        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", hightedImageName: "", imageWidth: 0, imageHeight: 0)
        //设置右侧item
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightedImageName: "Image_my_history_click", imageWidth: 30,imageHeight: 30)
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightedImageName: "btn_search_clicked", imageWidth: 30,imageHeight: 30)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightedImageName: "Image_scan_click", imageWidth: 30,imageHeight: 30)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}

//实现pageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(pageTitleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
    
}

//实现pageContentViewDelegate
extension HomeViewController : PageContentViewDelegate{
    func changeScrollLinex(pageContentView: PageContentView, scrollLinex: CGFloat,sourceLinex: CGFloat) {
        pageTitleView.changeScorllx(scrollx: scrollLinex,sourceLinex: sourceLinex)
    }
}
