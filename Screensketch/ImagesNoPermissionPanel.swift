//
//  ImagesNoPermissionPanel.swift
//  Screensketch
//
//  Created by Ricardo Pereira on 18/07/16.
//  Copyright © 2016 Ricardo Pereira. All rights reserved.
//

import UIKit

class ImagesNoPermissionPanel: UIView {

    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let settingsButton = UIButton(type: .System)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteColor()
        
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

        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle2)
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .Center
        stackView.addArrangedSubview(titleLabel)

        subtitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        subtitleLabel.lineBreakMode = .ByWordWrapping
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .Center
        stackView.addArrangedSubview(subtitleLabel)

        settingsButton.clipsToBounds = true
        settingsButton.layer.cornerRadius = 6.0
        settingsButton.layer.borderColor = settingsButton.tintColor.CGColor
        settingsButton.layer.borderWidth = 1.0
        settingsButton.setTitle("Open Settings", forState: .Normal)
        settingsButton.addTarget(self, action: #selector(didTouchSettings), forControlEvents: .TouchUpInside)
        stackView.addArrangedSubview(settingsButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func didTouchSettings(sender: AnyObject) {
        if let appSettingsURL = NSURL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.sharedApplication().openURL(appSettingsURL)
        }
    }
    
}
