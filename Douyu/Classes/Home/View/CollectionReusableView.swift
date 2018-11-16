//
//  CollectionReusableView.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/12.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var group: AnchorGroup? {
        didSet {
            self.titleLabel.text = group?.tag_name
            self.iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}
