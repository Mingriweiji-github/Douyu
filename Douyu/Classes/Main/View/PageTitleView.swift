//
//  PageTitleView.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/8.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

//MARK: - 定义协议
protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}
//MARK: - 定义b常量
private let kScrollLineH: CGFloat = 2
private let kNormalColor: (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSeletedColor: (CGFloat,CGFloat,CGFloat) = (255,128,128)

//MARK: - 定义PageTitleView 类
class PageTitleView: UIView {
    
    var titles: [String]
    var currentIndex: Int = 0
    weak var delegate: PageTitleViewDelegate?
    
    //scrollView
    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    //scrollView line
    lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor(r: kSeletedColor.0, g: kSeletedColor.1, b: kSeletedColor.2)
        return scrollLine
    }()
    
    //titleLabels
    lazy var titleLabels: [UILabel] = [UILabel]()
    
    //MARK: 便利构造函数
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        //自定义UI
        setuUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK:  UI界面
extension PageTitleView {
    func setuUI() {
        
        scrollView.frame = bounds
        addSubview(scrollView)
        
        setupLabels()
        
        setupBottomLineAndScrollViewLine()
    }
    
    
    func setupLabels() {
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let lebelY: CGFloat = 0

        for (index, title) in titles.enumerated(){
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: lebelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //titleLabels添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    func setupBottomLineAndScrollViewLine() {
        //1.bottom line
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        let bottomLineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - bottomLineH, width: kScreenW, height: bottomLineH)
        addSubview(bottomLine)
        
        //2.ScrollView line
        scrollView.addSubview(scrollLine)
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor(r: kSeletedColor.0, g: kSeletedColor.1, b: kSeletedColor.2)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
}

extension PageTitleView {
    @objc func titleLabelClick(tapGes: UITapGestureRecognizer) {
        print("-------")
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        if currentLabel.tag == currentIndex { return }
        
        let oldLabel = titleLabels[currentIndex]
        
        currentLabel.textColor = UIColor(r: kSeletedColor.0, g: kSeletedColor.1, b: kSeletedColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentLabel.tag
        
        let scrollLineX = scrollLine.frame.width * CGFloat(currentIndex)
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
//MARK: - 处理滑块逻辑
extension PageTitleView {
    func setTitleWithProgress(progress: CGFloat, startIndex: Int, targetIndex: Int) {
        let sourceLabel = titleLabels[startIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //color变化
        let colorDelta = (kSeletedColor.0 - kNormalColor.0, kSeletedColor.1 - kNormalColor.1,kSeletedColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSeletedColor.0 - colorDelta.0 * progress, g: kSeletedColor.1 - colorDelta.1 * progress, b: kSeletedColor.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        currentIndex = targetIndex
    }
}
