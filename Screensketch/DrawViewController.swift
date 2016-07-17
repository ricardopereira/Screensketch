//
//  DrawViewController.swift
//  Screensketch
//
//  Created by Ricardo Pereira on 17/07/16.
//  Copyright © 2016 Ricardo Pereira. All rights reserved.
//

import UIKit
import Photos

class DrawViewController: UIViewController {

    let asset: PHAsset

    let drawView = DrawView()

    let saveButton = UIButton(type: .System)
    let cancelButton = UIButton(type: .System)

    init(asset: PHAsset) {
        self.asset = asset
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()
        setupUI()

        PHImageManager.defaultManager().requestImageForAsset(self.asset, targetSize: PHImageManagerMaximumSize, contentMode: .Default, options: PHImageRequestOptions(), resultHandler: { result, _ in
            if let image = result {
                self.drawView.backgroundImage = image
            }
        })
    }

    func setupUI() {
        drawView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(drawView)
        NSLayoutConstraint.activateConstraints([
            drawView.topAnchor.constraintEqualToAnchor(view.topAnchor),
            drawView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
            drawView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
            drawView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
        ])

        saveButton.setTitle("Save", forState: .Normal)
        saveButton.backgroundColor = .lightGrayColor()
        saveButton.layer.cornerRadius = 6.0
        saveButton.clipsToBounds = true
        saveButton.addTarget(self, action: #selector(didTouchSave), forControlEvents: .TouchUpInside)

        cancelButton.setTitle("Close", forState: .Normal)
        cancelButton.backgroundColor = .lightGrayColor()
        cancelButton.layer.cornerRadius = 6.0
        cancelButton.clipsToBounds = true
        cancelButton.addTarget(self, action: #selector(didTouchCancel), forControlEvents: .TouchUpInside)

        let stackView = UIStackView()
        stackView.axis = .Horizontal
        stackView.distribution = .FillEqually
        stackView.alignment = .Fill
        stackView.spacing = 30
        stackView.addArrangedSubview(saveButton)
        stackView.addArrangedSubview(cancelButton)
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            stackView.heightAnchor.constraintEqualToConstant(44),
            stackView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -15),
        ])
    }

    func didTouchSave(sender: AnyObject) {
        drawView.saveDrawing()
    }

    func didTouchCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
