//
//  CollectionCycleCell.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/16.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = .flexibleWidth

    }
    var cycleModel: CycleModel? {
        didSet {
            
            guard let model = cycleModel else { return }
            
            let imageURL = URL(string: model.pic_url ?? "")
            iconImageView.kf.setImage(with: imageURL)
            
            titleLabel.text = model.title
        }
    }
    
}
