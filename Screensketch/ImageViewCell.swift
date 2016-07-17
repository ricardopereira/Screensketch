//
//  ImageViewCell.swift
//  Screensketch
//
//  Created by Ricardo Pereira on 17/07/16.
//  Copyright © 2016 Ricardo Pereira. All rights reserved.
//

import UIKit

class ImageViewCell: UICollectionViewCell {

    private let titleLabel = UILabel()
    var title: String = "" {
        didSet {
            if title.isEmpty {
                titleLabel.removeFromSuperview()
            }
            else if titleLabel.superview == nil {
                self.contentView.addSubview(titleLabel)
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activateConstraints([
                    titleLabel.topAnchor.constraintEqualToAnchor(contentView.topAnchor),
                    titleLabel.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor),
                    titleLabel.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor),
                    titleLabel.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor),
                    ])
                titleLabel.text = title
            }
            else {
                titleLabel.text = title
            }
        }
    }
    
}
