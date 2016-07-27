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

    let colorButton = UIButton(type: .System)
    let shareButton = UIButton(type: .System)
    let saveButton = UIButton(type: .System)
    let cancelButton = UIButton(type: .System)

    var selectedPenColor: UIColor {
        didSet {
            updatePen()
        }
    }

    init(asset: PHAsset) {
        self.asset = asset
        self.selectedPenColor = StyleKit.colorPenDefault
        super.init(nibName: nil, bundle: nil)
        updatePen()
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

        colorButton.accessibilityValue = "Color Button"
        colorButton.addTarget(self, action: #selector(didTouchColor), forControlEvents: .TouchUpInside)
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(colorButton)
        NSLayoutConstraint.activateConstraints([
            colorButton.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 10),
            colorButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -10),
            colorButton.heightAnchor.constraintEqualToConstant(44),
            colorButton.widthAnchor.constraintEqualToConstant(44),
        ])

        cancelButton.accessibilityValue = "Cancel Button"
        cancelButton.setImage(StyleKit.imageOfCloseCanvas(frame: CGRect(x: 0, y: 0, width: 25, height: 27)), forState: .Normal)
        cancelButton.addTarget(self, action: #selector(didTouchCancel), forControlEvents: .TouchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cancelButton)
        NSLayoutConstraint.activateConstraints([
            cancelButton.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 10),
            cancelButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 10),
            cancelButton.heightAnchor.constraintEqualToConstant(44),
            cancelButton.widthAnchor.constraintEqualToConstant(44),
        ])

        shareButton.accessibilityValue = "Save Button"
        saveButton.setImage(StyleKit.imageOfDownloadCanvas(frame: CGRect(x: 0, y: 0, width: 38, height: 38)), forState: .Normal)
        saveButton.addTarget(self, action: #selector(didTouchSave), forControlEvents: .TouchUpInside)

        shareButton.accessibilityValue = "Share Button"
        shareButton.setImage(StyleKit.imageOfShareCanvas(frame: CGRect(x: 0, y: 0, width: 38, height: 38)), forState: .Normal)
        shareButton.addTarget(self, action: #selector(didTouchShare), forControlEvents: .TouchUpInside)

        let stackView = UIStackView()
        stackView.axis = .Horizontal
        stackView.distribution = .FillEqually
        stackView.alignment = .Fill
        stackView.spacing = 30
        stackView.addArrangedSubview(saveButton)
        stackView.addArrangedSubview(shareButton)
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            stackView.heightAnchor.constraintEqualToConstant(44),
            stackView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -15),
        ])
    }

    func updatePen() {
        drawView.drawColor = selectedPenColor
        colorButton.setImage(StyleKit.imageOfColorSelectorCanvas(selectedColor: selectedPenColor), forState: .Normal)
    }

    func didTouchSave(sender: AnyObject) {
        drawView.saveDrawing()
        showMessage("Screensketch", message: "Saved successfully")
    }

    func didTouchCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func didTouchShare(sender: AnyObject) {
        let activityViewController = UIActivityViewController(activityItems: [drawView.currentDrawing], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }

    func didTouchColor(sender: AnyObject) {
        switch self.selectedPenColor {
        case StyleKit.colorPenDefault:
            selectedPenColor = StyleKit.colorPenBlue
        case StyleKit.colorPenBlue:
            selectedPenColor = StyleKit.colorPenGreen
        case StyleKit.colorPenGreen:
            selectedPenColor = StyleKit.colorPenYellow
        default:
            selectedPenColor = StyleKit.colorPenDefault
        }
    }

}

extension DrawViewController {

    func showMessage(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: handler)
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }

}
