//
//  PageContentView.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/9.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate:class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: CGFloat, endIndex: CGFloat)
}

private let ContentCellID = "ContentCellID"
class PageContentView: UIView {
    
    var childrens: [UIViewController] = [UIViewController]()
//    let parentVC
    weak var parentVC: UIViewController?
    var isForbidScrollViewDelegate: Bool = false
    weak var delegate: PageContentViewDelegate?
    var startOffSetX: CGFloat = 0
    
    //MARK: -lazy
    lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
       let collectionV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.isPagingEnabled = true
        collectionV.bounces = true
        collectionV.dataSource = self
        collectionV.delegate = self as? UICollectionViewDelegate
        collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionV
    }()

    
    init(frame: CGRect, childs: [UIViewController], parentViewController: UIViewController?) {
        self.childrens = childs
        self.parentVC = parentViewController
        
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    func setupUI() {
        for childVcs in childrens {
            parentVC?.addChildViewController(childVcs)
        }
        
        addSubview(self.collectionView)
        collectionView.frame = bounds
    }
}

//MARK: -准守 UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childrens.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        //设置cell内容
        let childVC = childrens[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}
//MARK: -准守 UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollViewDelegate = false
        startOffSetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.定义sourceIndex endIndex
        var progress: CGFloat = 0
        var startIndex: Int = 0
        var targeIndex: Int = 0
        //2.判断左滑还是右滑>
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if Int(currentOffsetX) > startIndex {
            
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            startIndex = Int(currentOffsetX / scrollViewW)
            
            targeIndex = startIndex + 1
            if targeIndex >= childrens.count {
                targeIndex = childrens.count - 1
            }
            
            //如果完全划过去
            if Int(currentOffsetX) - startIndex == Int(scrollViewW) {
                progress = 1
                targeIndex = startIndex
            }
            
        }else {
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targeIndex = Int(currentOffsetX / scrollViewW)
            startIndex = targeIndex - 1
            
            if startIndex >= childrens.count {
                startIndex = childrens.count
            }else if startIndex < 0{
                startIndex = 0
            }
        }
        
        print("progress:\(progress) start:\(startIndex) end:\(targeIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: CGFloat(startIndex), endIndex: CGFloat(targeIndex))
    }
}
//MARK: - 对外暴露
extension PageContentView {
    func setCurrentIndex(currentIndex: Int){
        
        isForbidScrollViewDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
