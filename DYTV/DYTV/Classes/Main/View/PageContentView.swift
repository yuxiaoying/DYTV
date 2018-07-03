//
//  PageContentView.swift
//  DYTV
//
//  Created by 寂惺 on 2018/7/2.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit

private let contentCellId = "contentCellId"

class PageContentView: UIView {
    private var childVcs : [UIViewController]
    private var parentVc : UIViewController
    
    //懒加载collectionView
    private lazy var collectionView: UICollectionView = {
        //设置布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size //设置item大小
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal //水平滑动
        
        //创建
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false //不超出内容滚动区域
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellId)
        return collectionView
    }()
    
    init(frame: CGRect,childVcs: [UIViewController] , parentVc:UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageContentView{
    private func setupUI(){
        for childVc in childVcs{
            parentVc.addChildViewController(childVc)
        }
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.blue
    }
}

extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellId, for: indexPath)
        
        //给cell设置内容
        for subView in cell.contentView.subviews{
            subView.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        
        return cell
    }
}
