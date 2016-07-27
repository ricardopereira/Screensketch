//
//  ImagesViewController.swift
//  Screensketch
//
//  Created by Ricardo Pereira on 17/07/16.
//  Copyright © 2016 Ricardo Pereira. All rights reserved.
//

import UIKit
import Photos

protocol ViewControllerAccessPrivacy {
    func verifyPermissions()
}

class ImagesViewController: UIViewController, ViewControllerAccessPrivacy {

    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())

    let loadingLabel = UILabel()
    let loadingSpinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)

    lazy var emptyPanel = ImagesEmptyPanel(frame: CGRect(x: 0, y: 0, width: 280, height: 280))
    lazy var noPermissionPanel = ImagesNoPermissionPanel(frame: CGRect(x: 0, y: 0, width: 280, height: 200))

    typealias PHAssetIdentifier = String
    var imagesCache = [PHAssetIdentifier:UIImage]()

    var imagesList = [PHAsset]() {
        didSet {
            collectionView.reloadData()
        }
    }

    enum ImageListState {
        case Default
        case Empty
        case NoPermission
    }

    var imageListState: ImageListState = .Empty {
        didSet {
            switch imageListState {
            case .Empty:
                collectionView.hidden = true
                emptyPanel.hidden = false
                noPermissionPanel.hidden = true
            case .NoPermission:
                collectionView.hidden = true
                emptyPanel.hidden = true
                noPermissionPanel.hidden = false
            default:
                collectionView.hidden = false
                emptyPanel.hidden = true
                noPermissionPanel.hidden = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotifications()
        collectionView.registerClass(ImageViewCell.self, forCellWithReuseIdentifier: String(ImageViewCell))
        collectionView.dataSource = self
        collectionView.delegate = self
        setupUI()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        verifyPhotosPermission()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }

    deinit {
        unregisterNotifications()
    }

    func setupUI() {
        view.backgroundColor = .whiteColor()

        loadingLabel.text = "Loading"
        loadingLabel.textAlignment = .Center
        loadingLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        loadingLabel.sizeToFit()
        loadingLabel.center = view.center
        view.addSubview(loadingLabel)

        loadingSpinner.startAnimating()
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingSpinner)
        NSLayoutConstraint.activateConstraints([
            loadingSpinner.bottomAnchor.constraintEqualToAnchor(loadingLabel.topAnchor, constant: -10),
            loadingSpinner.centerXAnchor.constraintEqualToAnchor(loadingLabel.centerXAnchor)
        ])

        view.addSubview(emptyPanel)
        emptyPanel.center = view.center
        emptyPanel.hidden = true
        emptyPanel.descriptionLabel.text = "Perform a screenshot on your iOS device:\n\n 1. Press and hold the Sleep/Wake button on the top or side of your device.\n\n 2. Immediately press and release the Home button.\n\n The screenshot is available in Photos.app > Albums > Screenshots."

        view.addSubview(noPermissionPanel)
        noPermissionPanel.center = view.center
        noPermissionPanel.hidden = true
        noPermissionPanel.clipsToBounds = true
        noPermissionPanel.layer.cornerRadius = 6.0
        noPermissionPanel.titleLabel.text = "Screenshots Album: No Access"
        noPermissionPanel.subtitleLabel.text = "The Photos permission was not authorized. Please enable it in Settings > Screensketch > Photos."

        collectionView.flowLayout.sectionInset = UIEdgeInsets(top: 30, left: 20, bottom: 25, right: 20)
        collectionView.flowLayout.minimumLineSpacing = collectionView.flowLayout.sectionInset.bottom
        collectionView.flowLayout.minimumInteritemSpacing = 10
        let cellWidth = (self.view.frame.width / 2) - (collectionView.flowLayout.minimumLineSpacing + collectionView.flowLayout.minimumInteritemSpacing)
        let cellHeight = cellWidth * 1.5
        collectionView.flowLayout.itemSize = CGSizeMake(cellWidth, cellHeight)

        collectionView.hidden = true
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

        loadingLabel.hidden = true
        loadingSpinner.hidden = true
        loadingSpinner.stopAnimating()

        guard let albumScreenshots = collections.lastObject as? PHAssetCollection else {
            imageListState = .Empty
            return
        }

        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType = %i", PHAssetMediaType.Image.rawValue)
        let assets = PHAsset.fetchAssetsInAssetCollection(albumScreenshots, options: fetchOptions)

        if assets.count == 0 {
            imageListState = .Empty
            return
        }

        var result = [PHAsset]()
        assets.enumerateObjectsUsingBlock { asset, _, _ in
            guard let assetInstance = asset as? PHAsset else {
                return
            }
            result.append(assetInstance)

            let requestOptions = PHImageRequestOptions()
            requestOptions.synchronous = true
            PHImageManager.defaultManager().requestImageForAsset(assetInstance, targetSize: self.collectionView.flowLayout.itemSize, contentMode: .Default, options: requestOptions, resultHandler: { result, _ in
                if let image = result, localIdentifier = asset.localIdentifier {
                    self.imagesCache[localIdentifier] = image
                }
            })
        }

        imageListState = .Default
        self.imagesList = result

        dispatch_async(dispatch_get_main_queue()) {
            self.collectionView.reloadData()
        }
    }

    func registerNotifications() {
        // Notify when the Photo library has changed
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
    }

    func unregisterNotifications() {
        PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
    }

    func verifyPermissions() {

    }

    func verifyPhotosPermission(status: PHAuthorizationStatus? = nil) {
        switch status ?? PHPhotoLibrary.authorizationStatus() {
        case .Authorized:
            loadContent()
        case .NotDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                self.verifyPhotosPermission(status)
            }
        default:
            imageListState = .NoPermission
        }
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
        cell.contentView.layer.contents = self.imagesCache[asset.localIdentifier ?? ""]?.CGImage
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let asset = imagesList[indexPath.item]
        let drawViewController = DrawViewController(asset: asset)
        drawViewController.modalTransitionStyle = .CrossDissolve
        drawViewController.modalPresentationStyle = .OverCurrentContext
        self.presentViewController(drawViewController, animated: true, completion: nil)
    }

}

extension ImagesViewController: PHPhotoLibraryChangeObserver {

    func photoLibraryDidChange(changeInstance: PHChange) {
        dispatch_async(dispatch_get_main_queue()) {
            self.verifyPhotosPermission()
        }
    }

}
