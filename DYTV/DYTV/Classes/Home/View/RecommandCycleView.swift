//
//  RecommandCycleView.swift
//  DYTV
//
//  Created by 寂惺 on 2018/7/12.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit
private let kCycleCellId = "kCycleCellId"
class RecommandCycleView: UIView {
    private var timer:Timer?
    private lazy var recommandVM : RecommandViewModel = RecommandViewModel()
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    

    //系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellId)
        collectionView.register(UINib(nibName: "CycleCollectionCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellId)
        recommandVM.requestCycleData {
            self.pageControl.numberOfPages = self.recommandVM.allCycleVos.count
            self.collectionView.reloadData()
            
            let indexpath = IndexPath(item: self.recommandVM.allCycleVos.count*100, section: 0)
            self.collectionView.scrollToItem(at: indexpath as IndexPath, at: UICollectionViewScrollPosition.left, animated: false)
            //定时器
            self.destoryTimer()
            self.createTimer()
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        
    }
    

}

extension RecommandCycleView{
    class func create()->RecommandCycleView{
        return Bundle.main.loadNibNamed("RecommandCycleView", owner: nil, options: nil)?.first as! RecommandCycleView
    }
}
//实现数据代理
extension RecommandCycleView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommandVM.allCycleVos.count*10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as!CycleCollectionCell
        let cycleVo = recommandVM.allCycleVos[indexPath.item%recommandVM.allCycleVos.count]
        cell.reloadCell(cycleVo: cycleVo)
        return cell
    }
}


//实现基本代理
extension RecommandCycleView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsent = collectionView.contentOffset.x+KScreenW/2
        let pageIndex = Int(contentOffsent/KScreenW)
        pageControl.currentPage = pageIndex%(recommandVM.allCycleVos.count)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        destoryTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        createTimer()
    }
}

//定时器
extension RecommandCycleView{
    private func createTimer(){
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    private func destoryTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    @objc func scrollToNext(){
        let currentOffsentX = collectionView.contentOffset.x
        collectionView.setContentOffset(CGPoint(x: currentOffsentX+KScreenW, y: 0), animated: true)
    }
}
