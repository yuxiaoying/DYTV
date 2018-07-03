//
//  PageTitleView.swift
//  DYTV
//
//  Created by 寂惺 on 2018/6/28.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit

let kScrollLineH:CGFloat = 2
class PageTitleView: UIView {
    //定义标题名称
    private var titles:[String]
    private lazy var titleLabels : [UILabel] = [UILabel]()
    //懒加载scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.frame = bounds
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        return scrollView
    }()
    
    //懒加载scrollLine
    private lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
   
    
    //自定义构造函数
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//设置UI界面
extension PageTitleView{
    private func setupUI(){
        //增加scrollView
        addSubview(scrollView)
        
        //增加title对应的label
        setupTitleLabels()
        
        //设置底线和滚动滑块
        setupBottomLineAndScrollLine()
        
    }
    
    private func setupTitleLabels(){
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        for (index,title) in titles.enumerated() {
            //创建UILabel
            let label = UILabel()
            label.text = title
            label.tag = index
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16.0)

            let labelX : CGFloat = labelW*CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    private func setupBottomLineAndScrollLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.darkGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //获取第一个label
        guard let label = titleLabels.first else{return}
        scrollLine.frame = CGRect(x: label.frame.origin.x, y: frame.height-kScrollLineH, width: label.frame.size.width, height: kScrollLineH)
        
        scrollView.addSubview(scrollLine)
        label.textColor = UIColor.orange
    }
}
