//
//  ContentSizeTableView.swift
//
//  Created by abuzeid on 7/9/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

