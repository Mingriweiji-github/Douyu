//
//  HomeViewController.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/8.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {

    //设置懒加载属性
    lazy var pageTitleView: PageTitleView = {[weak self] in
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width:kScreenW , height: kTitleViewH)
        let titles = ["推荐","游戏","颜值","户外",] //"旅游","英雄联盟","穿越火线"
        let titleView = PageTitleView.init(frame: frame, titles: titles)
        titleView.delegate = self as! PageTitleViewDelegate
        return titleView
    }()
    
    lazy var pageContentView: PageContentView = {[weak self] in
        let frameY = kStatusBarH + kNavigationBarH + kTitleViewH
        let frame = CGRect(x: 0, y: frameY, width: kScreenW, height: kScreenH - frameY)
        var childrens = [UIViewController]()
        for _ in 0..<4 {
            let child = UIViewController()
            child.view.backgroundColor = UIColor(
                r: CGFloat(arc4random_uniform(255)),
                g: CGFloat(arc4random_uniform(255)),
                b: CGFloat(arc4random_uniform(255))
            )
            childrens.append(child)
        }
        
        let contentView = PageContentView(frame: frame, childs: childrens, parentViewController: self)
        contentView.delegate = self as! PageContentViewDelegate
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

extension HomeViewController {
    func setupUI() {
        //0.不要调整scrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        //1.设置导航栏(class便利构造函数)
        setupNavigation()
        //2.设置titleView(UIView 自定义构造函数)
        view.addSubview(self.pageTitleView)
        
        view.addSubview(self.pageContentView)
        self.pageContentView.backgroundColor = UIColor.orange
    }
    private func setupNavigation() {
        
        let size = CGSize(width: 40, height: 40)
        //left item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //right Items
        let historyItem = UIBarButtonItem.init(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem.init(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem.init(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
    
}
//MARK: - 准守PageTitleViewDelegate
extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int){
        pageContentView.setCurrentIndex(currentIndex: index)
    }

}
//MARK: - 准守PageContentViewDelegate
extension HomeViewController: PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: CGFloat, endIndex: CGFloat)
    {
        pageTitleView.setTitleWithProgress(progress: progress, startIndex: Int(sourceIndex), targetIndex: Int(endIndex))
    }
}
