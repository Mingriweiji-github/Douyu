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
    lazy var pageTitleView: PageTitleView = {
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width:kScreenW , height: kTitleViewH)
        let titles = ["推荐","游戏","颜值","户外",] //"旅游","英雄联盟","穿越火线"
        let titleView = PageTitleView.init(frame: frame, titles: titles)
        return titleView
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
