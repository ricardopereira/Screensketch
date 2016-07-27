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

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.contentMode = .ScaleAspectFill
        contentView.clipsToBounds = true

        layer.shadowColor = UIColor.darkGrayColor().CGColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 6.0
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: layer.cornerRadius).CGPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.mainScreen().scale
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
