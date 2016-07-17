//
//  DrawView.swift
//  Screensketch
//
//  Created by Ricardo Pereira on 17/07/16.
//  Copyright © 2016 Ricardo Pereira. All rights reserved.
//

import UIKit

class DrawView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        internalInit()
    }

    private func internalInit() {
        backgroundColor = .grayColor()
        setupGestureRecognizers()
    }


    // MARK: Drawing a path

    override func drawRect(rect: CGRect) {
        // 4. Redraw whole rect, ignoring parameter. Please note we always invalidate whole view.
        let context = UIGraphicsGetCurrentContext()
        self.drawColor.setStroke()
        self.path.lineWidth = self.drawWidth
        self.path.lineCapStyle = CGLineCap.Round
        self.path.stroke()
    }


    // MARK: Gestures

    private func setupGestureRecognizers() {
        // 1. Set up a pan gesture recognizer to track where user moves finger
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
        case .Ended:
            self.endAtPoint(point)
        case .Failed:
            self.endAtPoint(point)
        default:
            assert(false, "State not handled")
        }
    }


    // MARK: Tracing a line

    private func startAtPoint(point: CGPoint) {
        self.path.moveToPoint(point)
    }

    private func continueAtPoint(point: CGPoint) {
        // 2. Accumulate points as they are reported by the gesture recognizer, in a bezier path object
        self.path.addLineToPoint(point)

        // 3. Trigger a redraw every time a point is added (finger moves)
        self.setNeedsDisplay()
    }

    private func endAtPoint(point: CGPoint) {
        // Nothing to do when ending/cancelling for now
    }

    var drawColor: UIColor = UIColor.blackColor()
    var drawWidth: CGFloat = 10.0

    private var path: UIBezierPath = UIBezierPath()

}
