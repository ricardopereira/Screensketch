//
//  StyleKitExtension.swift
//  Screensketch
//
//  Created by Ricardo Pereira on 18/07/16.
//  Copyright © 2016 Ricardo Pereira. All rights reserved.
//

import UIKit

extension StyleKit {

    /// Drawing Methods

    public class func drawColorSelectorCanvas(frame frame: CGRect = CGRect(x: 0, y: 0, width: 31, height: 34), selectedColor: UIColor = StyleKit.colorPenDefault) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let fillColorBlack = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let fillColorWhite = selectedColor

        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.lightGrayColor()
        shadow.shadowOffset = CGSize(width: 0.1, height: 2.1)
        shadow.shadowBlurRadius = 4


        //// Subframes
        let colorIcon: CGRect = CGRect(x: frame.minX + 2, y: frame.minY + 2, width: frame.width - 6, height: frame.height - 9)


        //// Color Icon
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
        CGContextBeginTransparencyLayer(context, nil)


        //// Color Group
        //// Oval-Shape
        //// path-3 Drawing
        let path3Path = UIBezierPath()
        path3Path.moveToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height))
        path3Path.addLineToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height))
        path3Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.80624 * colorIcon.width, y: colorIcon.minY + 0.49956 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.66894 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.80624 * colorIcon.width, y: colorIcon.minY + 0.66894 * colorIcon.height))
        path3Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.19288 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.80624 * colorIcon.width, y: colorIcon.minY + 0.33019 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.66894 * colorIcon.width, y: colorIcon.minY + 0.19288 * colorIcon.height))
        path3Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.19288 * colorIcon.width, y: colorIcon.minY + 0.49956 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.33019 * colorIcon.width, y: colorIcon.minY + 0.19288 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.19288 * colorIcon.width, y: colorIcon.minY + 0.33019 * colorIcon.height))
        path3Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.19288 * colorIcon.width, y: colorIcon.minY + 0.66894 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.33019 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height))
        path3Path.addLineToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height))
        path3Path.closePath()
        path3Path.moveToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height))
        path3Path.addLineToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height))
        path3Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.00000 * colorIcon.width, y: colorIcon.minY + 0.50000 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.22386 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.00000 * colorIcon.width, y: colorIcon.minY + 0.77614 * colorIcon.height))
        path3Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 0.00000 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.00000 * colorIcon.width, y: colorIcon.minY + 0.22386 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.22386 * colorIcon.width, y: colorIcon.minY + 0.00000 * colorIcon.height))
        path3Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 1.00000 * colorIcon.width, y: colorIcon.minY + 0.50000 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.77614 * colorIcon.width, y: colorIcon.minY + 0.00000 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 1.00000 * colorIcon.width, y: colorIcon.minY + 0.22386 * colorIcon.height))
        path3Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 1.00000 * colorIcon.width, y: colorIcon.minY + 0.77614 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.77614 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height))
        path3Path.addLineToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height))
        path3Path.closePath()
        path3Path.miterLimit = 4;

        path3Path.usesEvenOddFillRule = true;

        fillColorBlack.setFill()
        path3Path.fill()


        //// path-2 Drawing
        let path2Path = UIBezierPath()
        path2Path.moveToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height))
        path2Path.addLineToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height))
        path2Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.80624 * colorIcon.width, y: colorIcon.minY + 0.49956 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.66894 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.80624 * colorIcon.width, y: colorIcon.minY + 0.66894 * colorIcon.height))
        path2Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.19288 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.80624 * colorIcon.width, y: colorIcon.minY + 0.33019 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.66894 * colorIcon.width, y: colorIcon.minY + 0.19288 * colorIcon.height))
        path2Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.19288 * colorIcon.width, y: colorIcon.minY + 0.49956 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.33019 * colorIcon.width, y: colorIcon.minY + 0.19288 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.19288 * colorIcon.width, y: colorIcon.minY + 0.33019 * colorIcon.height))
        path2Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.19288 * colorIcon.width, y: colorIcon.minY + 0.66894 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.33019 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height))
        path2Path.addLineToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height))
        path2Path.closePath()
        path2Path.moveToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height))
        path2Path.addLineToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height))
        path2Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.00000 * colorIcon.width, y: colorIcon.minY + 0.50000 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.22386 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.00000 * colorIcon.width, y: colorIcon.minY + 0.77614 * colorIcon.height))
        path2Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 0.00000 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.00000 * colorIcon.width, y: colorIcon.minY + 0.22386 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.22386 * colorIcon.width, y: colorIcon.minY + 0.00000 * colorIcon.height))
        path2Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 1.00000 * colorIcon.width, y: colorIcon.minY + 0.50000 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.77614 * colorIcon.width, y: colorIcon.minY + 0.00000 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 1.00000 * colorIcon.width, y: colorIcon.minY + 0.22386 * colorIcon.height))
        path2Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 1.00000 * colorIcon.width, y: colorIcon.minY + 0.77614 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.77614 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height))
        path2Path.addLineToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height))
        path2Path.closePath()
        path2Path.miterLimit = 4;

        path2Path.usesEvenOddFillRule = true;

        fillColorWhite.setFill()
        path2Path.fill()


        //// path-1 Drawing
        let path1Path = UIBezierPath()
        path1Path.moveToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height))
        path1Path.addLineToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height))
        path1Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.80624 * colorIcon.width, y: colorIcon.minY + 0.49956 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.66894 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.80624 * colorIcon.width, y: colorIcon.minY + 0.66894 * colorIcon.height))
        path1Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.19288 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.80624 * colorIcon.width, y: colorIcon.minY + 0.33019 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.66894 * colorIcon.width, y: colorIcon.minY + 0.19288 * colorIcon.height))
        path1Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.19288 * colorIcon.width, y: colorIcon.minY + 0.49956 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.33019 * colorIcon.width, y: colorIcon.minY + 0.19288 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.19288 * colorIcon.width, y: colorIcon.minY + 0.33019 * colorIcon.height))
        path1Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.19288 * colorIcon.width, y: colorIcon.minY + 0.66894 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.33019 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height))
        path1Path.addLineToPoint(CGPoint(x: colorIcon.minX + 0.49956 * colorIcon.width, y: colorIcon.minY + 0.80624 * colorIcon.height))
        path1Path.closePath()
        path1Path.moveToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height))
        path1Path.addLineToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height))
        path1Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.00000 * colorIcon.width, y: colorIcon.minY + 0.50000 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.22386 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.00000 * colorIcon.width, y: colorIcon.minY + 0.77614 * colorIcon.height))
        path1Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 0.00000 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.00000 * colorIcon.width, y: colorIcon.minY + 0.22386 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.22386 * colorIcon.width, y: colorIcon.minY + 0.00000 * colorIcon.height))
        path1Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 1.00000 * colorIcon.width, y: colorIcon.minY + 0.50000 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 0.77614 * colorIcon.width, y: colorIcon.minY + 0.00000 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 1.00000 * colorIcon.width, y: colorIcon.minY + 0.22386 * colorIcon.height))
        path1Path.addCurveToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height), controlPoint1: CGPoint(x: colorIcon.minX + 1.00000 * colorIcon.width, y: colorIcon.minY + 0.77614 * colorIcon.height), controlPoint2: CGPoint(x: colorIcon.minX + 0.77614 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height))
        path1Path.addLineToPoint(CGPoint(x: colorIcon.minX + 0.50000 * colorIcon.width, y: colorIcon.minY + 1.00000 * colorIcon.height))
        path1Path.closePath()
        path1Path.miterLimit = 4;

        path1Path.lineCapStyle = .Round;

        path1Path.lineJoinStyle = .Round;

        path1Path.usesEvenOddFillRule = true;

        StyleKit.colorBase.setStroke()
        path1Path.lineWidth = 1
        path1Path.stroke()
        
        
        
        
        
        
        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)
    }

    public class func imageOfColorSelectorCanvas(frame frame: CGRect = CGRect(x: 0, y: 0, width: 31, height: 34), selectedColor: UIColor = StyleKit.colorPenDefault) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        StyleKit.drawColorSelectorCanvas(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), selectedColor: selectedColor)

        let imageOfColorCanvas = UIGraphicsGetImageFromCurrentImageContext().imageWithRenderingMode(.AlwaysOriginal)
        UIGraphicsEndImageContext()

        return imageOfColorCanvas
    }

}
