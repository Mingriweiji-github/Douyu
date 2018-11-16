//
//  RecommandViewController.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/12.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit
import Alamofire

private let kItemMargin: CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kNormalCellID = "CollectionNormalCell"
private let kPrettyCell = "kPrettyCell"
private let kHeaderViewID = "kHeaderViewID"
private let kCycleViewH = kScreenW * 3 / 8
class RecommandViewController: UIViewController {

    //MARK: - 懒加载
    lazy var recommandVM = RecommandVIewModel()
    lazy var collectionView: UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        print(self.view.bounds)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCell)
        
        collectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)

        return collectionView
    }()
    lazy var cycleView: RecommandCycleView = {
        let cycleView = RecommandCycleView.recommandCycle()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        setupUI()
        getHomeData()
    }

}
//MARK: -设置UI
extension RecommandViewController {
    func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.addSubview(cycleView)
        //设置内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0)
    }
    
    func getHomeData() {
        recommandVM.requestData {
            self.collectionView.reloadData()
        }
        
        recommandVM.requestCycleData {
            print("cycle data done")
            self.cycleView.cycleModels = self.recommandVM.cycleModels
            self.cycleView.collectionView.reloadData()
        }
    }
    
}
//MARK: -UICollectionViewDataSource
extension RecommandViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommandVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommandVM.anchorGroups[section]
        if section == 1 {
            
            return group.anchors.count >= 6 ? 6 : group.anchors.count
        }
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }else {
            return CGSize(width: kItemW, height: kNormalItemH)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recommandVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.row]
        if indexPath.section == 1 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCell, for: indexPath) as! CollectionPrettyCell
            cell.anchor = anchor
            return cell

        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            cell.model = anchor
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionReusableView
        let group = recommandVM.anchorGroups[indexPath.section]
        headerView.group = group
        return headerView
    }
}
