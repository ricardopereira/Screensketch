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

    let drawView = DrawView()
    let saveButton = UIButton(type: .System)

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

        saveButton.setTitle("Save", forState: .Normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        NSLayoutConstraint.activateConstraints([
            saveButton.heightAnchor.constraintEqualToConstant(44),
            saveButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
            saveButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            saveButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -10),
        ])
        saveButton.addTarget(self, action: #selector(didTouchSave), forControlEvents: .TouchUpInside)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        testLoadImage()
    }

    func didTouchSave(sender: AnyObject) {
        drawView.saveDrawing()
    }

    func testLoadImage() {
        let collections = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .SmartAlbumUserLibrary, options: nil)

        guard let albumScreenshots = collections.lastObject as? PHAssetCollection else {
            return
        }

        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType = %i", PHAssetMediaType.Image.rawValue)
        let assets = PHAsset.fetchAssetsInAssetCollection(albumScreenshots, options: fetchOptions)

        guard let asset = assets.firstObject as? PHAsset else {
            return
        }

        let imageRequestOptions = PHImageRequestOptions()
        imageRequestOptions.synchronous = true
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: .Default, options: imageRequestOptions, resultHandler: { result, info in
            // Test
            if let image = result {
                self.drawView.backgroundImage = image
            }
        })
    }

}
