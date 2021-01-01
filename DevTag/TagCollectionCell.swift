//
//  TagCollectionCell.swift
//  TagsUIView
//
//  Created by abuzeid on 5/18/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class TagCollectionCell: UICollectionViewCell {
    static let id = "TagCollectionCell"
    @IBOutlet private var iconView: UIImageView!
    @IBOutlet private var label: UILabel!
    func setFont(_ font: UIFont, bgColor: UIColor, txtColor: UIColor) {
        label.font = font
        backgroundColor = bgColor
        layer.borderColor = UIColor.lightGray.cgColor
        label.textColor = txtColor
    }

    func setCellModel(model: TagDataModel) {
        label.text = model.0
        if let img = model.1 {
            iconView.image = img
        } else {
            iconView.isHidden = true
        }
    }

    override func awakeFromNib() {
        layer.cornerRadius = 10
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
    }
}
