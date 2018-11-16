//
//  RecommandCycleView.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/16.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit
private var kCycleCellID = "kCycleCellID"
class RecommandCycleView: UIView {
    
    var cycleTime: Timer?
    
    var cycleModels: [CycleModel] = [] {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = cycleModels.count
            
            //默认位置为600,解决第一张左滑的问题
            let indexPath = IndexPath(item: (cycleModels.count ) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            //解决自动滑动
            removeTimer()
            addTimer()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置控件不随着父控件拉伸
        autoresizingMask = .flexibleWidth
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        //设置代理
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellID)
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
}

//MARK: - xib加载RecommandCycleView
extension RecommandCycleView {
    class func recommandCycle() -> RecommandCycleView {
        return Bundle.main.loadNibNamed("RecommandCycleView", owner: nil, options: nil)?.first as! RecommandCycleView
    }
}
//MARK: -设置代理
extension RecommandCycleView: UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels.count) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = self.cycleModels[indexPath.row % cycleModels.count]
        
        return cell
    }
    
    //mark: UICollectionViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        //取模解决最后一张右滑问题
        pageControl.currentPage = Int(offsetX / kScreenW) % (cycleModels.count ?? 1)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
}

extension RecommandCycleView {
    func addTimer() {
        cycleTime = Timer(timeInterval: 2.0, target: self, selector: #selector(scrollNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTime!, forMode: .commonModes)
    }
    func removeTimer() {
        cycleTime?.invalidate()
        cycleTime = nil
    }
    func scrollNext() {
        let collectionX = collectionView.contentOffset.x
        let offSetX = collectionX + collectionView.bounds.width
        
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
    }
}
