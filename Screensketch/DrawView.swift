//
//  DrawView.swift
//  Screensketch
//
//  Created by Ricardo Pereira on 17/07/16.
//  Copyright © 2016 Ricardo Pereira. All rights reserved.
//

import UIKit
import Photos

class DrawView: UIView {

    var drawColor: UIColor = StyleKit.colorPenDefault
    var drawWidth: CGFloat = 6.0

    var backgroundImage: UIImage? {
        didSet {
            self.buffer = backgroundImage
            self.layer.contents = self.buffer?.CGImage
        }
    }

    private var lastPoint: CGPoint = CGPointZero
    private var buffer: UIImage?

    override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        internalInit()
    }

    private func internalInit() {
        setupGestureRecognizers()
    }

    func saveDrawing() {
        guard let image = buffer else {
            return
        }
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromImage(image)
            },
            completionHandler: { success, error in
                if !success {
                    print(error)
                }
            }
        )
    }


    // MARK: Drawing a path

    private func drawLine(a: CGPoint, b: CGPoint, buffer: UIImage?) -> UIImage {
        let size = self.bounds.size

        // Initialize a full size image. Opaque because we don't need to draw over anything. Will be more performant.
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()

        CGContextSetFillColorWithColor(context, self.backgroundColor?.CGColor ?? UIColor.whiteColor().CGColor)
        CGContextFillRect(context, self.bounds)

        // Draw previous buffer first
        if let buffer = buffer {
            buffer.drawInRect(self.bounds)
        }

        // Draw the line
        self.drawColor.setStroke()
        CGContextSetLineWidth(context, self.drawWidth)
        CGContextSetLineCap(context, .Round)

        CGContextMoveToPoint(context, a.x, a.y)
        CGContextAddLineToPoint(context, b.x, b.y)
        CGContextStrokePath(context)

        // Grab the updated buffer
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }


    // MARK: Gestures

    private func setupGestureRecognizers() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DrawView.handlePan))
        self.addGestureRecognizer(panRecognizer)
    }

    @objc private func handlePan(sender: UIPanGestureRecognizer) {
        let point = sender.locationInView(self)
        switch sender.state {
        case .Began:
            self.startAtPoint(point)
        case .Changed:
            self.continueAtPoint(point)
        case .Ended, .Failed:
            self.endAtPoint(point)
        default:
            break
        }
    }


    // MARK: Tracing a line

    private func startAtPoint(point: CGPoint) {
        self.lastPoint = point
    }

    private func continueAtPoint(point: CGPoint) {
        autoreleasepool {
            // Draw the current stroke in an accumulated bitmap
            self.buffer = self.drawLine(self.lastPoint, b: point, buffer: self.buffer)
            // Replace the layer contents with the updated image
            self.layer.contents = self.buffer?.CGImage
            // Update last point for next stroke
            self.lastPoint = point
        }
    }

    private func endAtPoint(point: CGPoint) {
        self.lastPoint = CGPoint.zero
    }

}
