//
//  ImagesEmptyPanel.swift
//  Screensketch
//
//  Created by Ricardo Pereira on 18/07/16.
//  Copyright © 2016 Ricardo Pereira. All rights reserved.
//

import UIKit

class ImagesEmptyPanel: UIView {

    let titleLabel = UILabel()
    let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activateConstraints([
            stackView.topAnchor.constraintEqualToAnchor(self.topAnchor),
            stackView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor, constant: -10),
        ])

        stackView.axis = .Vertical
        stackView.distribution = .FillProportionally

        titleLabel.text = "No screenshots"
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
        titleLabel.textAlignment = .Center
        stackView.addArrangedSubview(titleLabel)

        descriptionLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        descriptionLabel.lineBreakMode = .ByWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .Center
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
