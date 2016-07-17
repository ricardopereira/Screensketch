//
//  DrawViewController.swift
//  Screensketch
//
//  Created by Ricardo Pereira on 17/07/16.
//  Copyright © 2016 Ricardo Pereira. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {

    let drawView = DrawView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()

        drawView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(drawView)
        NSLayoutConstraint.activateConstraints([
            drawView.topAnchor.constraintEqualToAnchor(view.topAnchor),
            drawView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
            drawView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
            drawView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
        ])
    }

}
