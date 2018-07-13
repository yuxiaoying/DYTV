//
//  RecommandViewController.swift
//  DYTV
//
//  Created by 寂惺 on 2018/7/5.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit
private let kItemMagin : CGFloat = 10
private let kItemW = (KScreenW - 3*kItemMagin)/2
private let kItemH = kItemW*3/4
private let kPrettryItemH = kItemW*4/3
private let kHeaderViewH :CGFloat = 50
private let kCycleViewH :CGFloat = kScreenH*1/5
private let kNormalCellId = "kNormalCellId"
private let kPrettyCellId = "kPrettyCellId"
private let kHeaderViewId = "kHeaderViewId"
class RecommandViewController: UIViewController {
    private lazy var recommandVM : RecommandViewModel = RecommandViewModel()

    private lazy var collectionView:UICollectionView = {[unowned  self]in
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width:kItemW , height: kItemH)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = kItemMagin
        //设置组内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMagin, bottom: 10, right: kItemMagin)
        //设置分组头size
        layout.headerReferenceSize = CGSize(width: KScreenW, height: kHeaderViewH)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellId)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewId)
        
        //设置内边距 适应无限轮播
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0)
        
        print("内边距:\(collectionView.contentInset.top) 轮播高：\(kCycleViewH)")
        return collectionView
    }()
    
    private lazy var cycleView :RecommandCycleView = {
        let cycleView = RecommandCycleView.create()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: KScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
}

extension RecommandViewController{
    private func setupUI(){
        view.addSubview(collectionView)
        
        reloadCollectionView()

    }
    
    private func reloadCollectionView(){
        collectionView.addSubview(cycleView)
        
        //self.view.backgroundColor = UIColor.blue
        recommandVM.requestData{[weak self]in
            self?.collectionView.reloadData()
        }
    }
}

extension RecommandViewController:UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommandVM.allRoomGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommandVM.allRoomGroups[section].roomList?.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let room = recommandVM.allRoomGroups[indexPath.section].roomList![indexPath.item]
        if indexPath.section == 1{
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellId, for: indexPath) as! CollectionPrettyCell
            cell.reloadCell(room: room)
            return cell
        }
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! CollectionNormalCell
            cell.reloadCell(room: room)
          return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewId, for: indexPath) as! CollectionHeaderView
        let roomGroup = recommandVM.allRoomGroups[indexPath.section]
        headerView.reloadHeader(roomGroup: roomGroup)
        return headerView
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if indexPath.section == 1{
            return CGSize(width: kItemW, height: kPrettryItemH)
        }
        
        return CGSize(width: kItemW, height: kItemH)
    }
    
    

}
