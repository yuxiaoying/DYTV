//
//  PageTitleView.swift
//  DYTV
//
//  Created by 寂惺 on 2018/6/28.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit

let kScrollLineH:CGFloat = 2
let kNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
let kSelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

protocol PageTitleViewDelegate : class {
    func pageTitleView(pageTitleView:PageTitleView,selectedIndex index :Int)
}

class PageTitleView: UIView {
    //定义标题名称
    private var titles:[String]
    private lazy var titleLabels : [UILabel] = [UILabel]()
    private var currentIndex:Int = 0
    weak var delegate : PageTitleViewDelegate?
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
            
            //设置label属性
            label.text = title
            label.tag = index
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16.0)

            //设置labelframe
            let labelX : CGFloat = labelW*CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)//方便处理label颜色
            
            //给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.changeContentView(tapGes:)))
            label.addGestureRecognizer(tapGes)
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
        label.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
    }
}

extension PageTitleView{
    @objc private func changeContentView(tapGes:UITapGestureRecognizer){
        guard let currentLabel = tapGes.view as?UILabel  else{return}
        let oldLabel = titleLabels[currentIndex]
        currentIndex = currentLabel.tag
        if(oldLabel.tag != currentLabel.tag){
            currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
            oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        }else{
            return
        }
        let scrollLineX = CGFloat(currentIndex)*scrollLine.frame.width
        scrollLine.frame.origin.x = scrollLineX
        delegate?.pageTitleView(pageTitleView: self, selectedIndex: currentIndex)
    }
}

//对外的方法
extension PageTitleView{
    func changeScorllx(scrollx:CGFloat,sourceLinex:CGFloat){
        scrollLine.frame.origin.x = scrollx
        guard let firstLabel = titleLabels[0] as UILabel?else{return}
        let labelWidth = firstLabel.frame.size.width
        let sourceLabelIndex = Int(sourceLinex/labelWidth)
        var targetLabelIndex = 0
        var progress:CGFloat = 0
        if(scrollx != sourceLinex){
            if(scrollx>sourceLinex){
                targetLabelIndex = sourceLabelIndex + 1
                progress = (scrollx - sourceLinex) / labelWidth
            }else{
                targetLabelIndex = sourceLabelIndex - 1
                progress = (sourceLinex - scrollx) / labelWidth
            }
        }else{
            return
        }
        let colorChange = (kSelectColor.0-kNormalColor.0,kSelectColor.1-kNormalColor.1,kSelectColor.2-kNormalColor.2)
        guard let sourceLabel = titleLabels[sourceLabelIndex] as UILabel?else{return}
        guard let targetLabel = titleLabels[targetLabelIndex] as UILabel?else{return}
        sourceLabel.textColor = UIColor(r: kSelectColor.0-colorChange.0*progress, g: kSelectColor.1-colorChange.1*progress, b: kSelectColor.2-colorChange.2*progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0+colorChange.0*progress, g: kNormalColor.1+colorChange.1*progress, b: kNormalColor.2+colorChange.2*progress)
        
        currentIndex = targetLabelIndex

        
    }
}

