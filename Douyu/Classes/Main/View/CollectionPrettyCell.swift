//
//  CollectionPrettyCell.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/13.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell: UICollectionViewCell {

    @IBOutlet weak var iconIamgeView: UIImageView!
    
    @IBOutlet weak var onlineButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var locLabel: UIButton!
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            var onlineStr = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Float(anchor.online / 10000))万在线"
            }else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineButton.setTitle(onlineStr, for: .normal)
            titleLabel.text = anchor.nickname
            locLabel.setTitle(anchor.anchor_city, for: .normal)
            guard let iconURL = URL(string: anchor.vertical_src) else {
                return
            }
            iconIamgeView.kf.setImage(with: iconURL)
        }
    }

}
