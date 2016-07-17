//
//  ImagesViewController.swift
//  Screensketch
//
//  Created by Ricardo Pereira on 17/07/16.
//  Copyright © 2016 Ricardo Pereira. All rights reserved.
//

import UIKit
import Photos

class ImagesViewController: UIViewController {

    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())

    typealias PHAssetIdentifier = String
    var imagesCache = [PHAssetIdentifier:UIImage]()

    var imagesList = [PHAsset]() {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerClass(ImageViewCell.self, forCellWithReuseIdentifier: String(ImageViewCell))
        collectionView.dataSource = self
        collectionView.delegate = self
        setupUI()
        loadContent()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }

    func setupUI() {
        collectionView.flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.flowLayout.minimumLineSpacing = collectionView.flowLayout.sectionInset.bottom
        collectionView.flowLayout.minimumInteritemSpacing = 10
        let cellWidth = (self.view.frame.width / 2) - (collectionView.flowLayout.minimumLineSpacing + collectionView.flowLayout.minimumInteritemSpacing)
        let cellHeight = cellWidth * 1.5
        collectionView.flowLayout.itemSize = CGSizeMake(cellWidth, cellHeight)

        collectionView.backgroundColor = .whiteColor()
        collectionView.scrollEnabled = true
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activateConstraints([
            collectionView.topAnchor.constraintEqualToAnchor(view.topAnchor),
            collectionView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
            collectionView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            collectionView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
        ])
    }

    func loadContent() {
        let collections = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: Device.isSimulator ? .SmartAlbumUserLibrary : .SmartAlbumScreenshots, options: nil)

        guard let albumScreenshots = collections.lastObject as? PHAssetCollection else {
            return
        }

        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType = %i", PHAssetMediaType.Image.rawValue)
        let assets = PHAsset.fetchAssetsInAssetCollection(albumScreenshots, options: fetchOptions)

        var result = [PHAsset]()
        assets.enumerateObjectsUsingBlock { asset, _, _ in
            guard let assetInstance = asset as? PHAsset else {
                return
            }
            result.append(assetInstance)

            PHImageManager.defaultManager().requestImageForAsset(assetInstance, targetSize: self.collectionView.flowLayout.itemSize, contentMode: .Default, options: PHImageRequestOptions(), resultHandler: { result, _ in
                if let image = result, localIdentifier = asset.localIdentifier {
                    self.imagesCache[localIdentifier] = image
                }
            })
        }

        self.imagesList = result
    }

}

private extension UICollectionView {

    var layout: UICollectionViewLayout {
        return collectionViewLayout
    }

    var flowLayout: UICollectionViewFlowLayout {
        return layout as? UICollectionViewFlowLayout ?? UICollectionViewFlowLayout()
    }
    
}

extension ImagesViewController: UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesList.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(String(ImageViewCell), forIndexPath: indexPath)
    }

}

extension ImagesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        guard let cell = cell as? ImageViewCell else {
            return
        }
        let asset = imagesList[indexPath.item]
        cell.contentView.contentMode = .ScaleAspectFill
        cell.contentView.clipsToBounds = true
        cell.contentView.layer.cornerRadius = 6.0
        cell.contentView.layer.contents = self.imagesCache[asset.localIdentifier ?? ""]?.CGImage
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let asset = imagesList[indexPath.item]
        let drawViewController = DrawViewController(asset: asset)
        self.presentViewController(drawViewController, animated: true, completion: nil)
    }

}
