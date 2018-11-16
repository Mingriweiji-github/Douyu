//
//  CollectionNormalCell.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/12.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: AnchorModel? {
        didSet {
            guard let group = model else {
                return
            }
            var onlineStr = ""
            if group.online > 10000 {
                onlineStr = "\(Float((group.online) / 10000))万人在线"
            }else {
                onlineStr = "\(group.online)人在线"
            }
            onlineButton.setTitle(onlineStr, for: .normal)
            nicknameLabel.text = group.nickname
            titleLabel.text = group.room_name
            
            guard let imgURL = URL(string: group.vertical_src) else { return }
            iconImageView.kf.setImage(with: imgURL)
        }
    }

}
