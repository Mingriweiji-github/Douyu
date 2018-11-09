//
//  PageTitleView.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/8.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

private let kScrollLineH: CGFloat = 2

class PageTitleView: UIView {
    
    var titles: [String]
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
        scrollLine.backgroundColor = UIColor.orange
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
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: lebelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    func setupBottomLineAndScrollViewLine() {
        //1.bottom line
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.darkGray
        let bottomLineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - bottomLineH, width: kScreenW, height: bottomLineH)
        addSubview(bottomLine)
        
        //2.ScrollView line
        scrollView.addSubview(scrollLine)
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor.orange
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
}
