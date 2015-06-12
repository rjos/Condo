//
//  VectorView.swift
//  Condo
//
//  Created by Lucas Tenório on 11/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit

class VectorView: UIView {
    var shapeLayer: CAShapeLayer? = nil
    var strokeColor = UIColor.blackColor() {
        didSet{
            self.applyPropertiesToShape()
        }
    }
    var fillColor = UIColor.blackColor() {
        didSet{
            self.applyPropertiesToShape()
        }
    }
    var lineWidth: CGFloat = 1.0 {
        didSet{
            self.applyPropertiesToShape()
        }
    }
    var onlyStrokeAfterAnimation = false{
        didSet {
            self.applyPropertiesToShape()
        }
    }
    var onlyFillAfterAnimation = false {
        didSet {
            self.applyPropertiesToShape()
        }
    }
    
    
    var animationDuration: NSTimeInterval = 1.0
    var animateFadeIn: Bool = true

    
    func drawSVGWithName(name: String) {
        if let shapeLayer = self.shapeLayer {
            shapeLayer.removeFromSuperlayer()
            self.shapeLayer = nil
        }
        let path = PocketSVG.pathFromSVGFileNamed(name).takeUnretainedValue()
        self.shapeLayer = CAShapeLayer()
        self.shapeLayer!.path = path;
        self.shapeLayer!.frame = self.bounds
        self.applyPropertiesToShape()
        self.layer.addSublayer(self.shapeLayer)
    }
    private func applyPropertiesToShape(){
        self.shapeLayer!.strokeColor = self.strokeColor.CGColor
        self.shapeLayer!.fillColor = self.onlyFillAfterAnimation ? UIColor.clearColor().CGColor : self.fillColor.CGColor
        self.shapeLayer!.lineWidth = self.lineWidth;
        self.shapeLayer!.frame = self.bounds;
        self.shapeLayer!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.shapeLayer!.position = self.layer.position
        
        
        self.shapeLayer!.strokeEnd = self.onlyStrokeAfterAnimation ? 0.0 : 1.0
    }
    func animateShape() {
        CATransaction.begin()
//        if self.onlyFillAfterAnimation {
//            self.shapeLayer?.fillColor = UIColor.clearColor().CGColor
//        }
        self.shapeLayer?.fillColor = UIColor.clearColor().CGColor
        let draw = CABasicAnimation(keyPath: "strokeEnd")
        draw.autoreverses = true
        draw.repeatCount = HUGE
        draw.fromValue = 0.0
        draw.toValue = 1.0
        draw.duration = self.animationDuration
        draw.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.autoreverses = true
        fade.repeatCount = HUGE
        fade.fromValue = 0.0
        fade.toValue = 1.0
        fade.duration = self.animationDuration
        fade.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let group = CAAnimationGroup()
        
        group.animations = self.animateFadeIn ? [draw, fade] : [draw]
        group.duration = self.animationDuration
        
        CATransaction.setCompletionBlock { () -> Void in
            self.shapeLayer?.fillColor = self.fillColor.CGColor
            self.shapeLayer?.strokeEnd = 1.0
//            self.onlyStrokeAfterAnimation = false
//            self.onlyFillAfterAnimation = false
        }
        
        self.shapeLayer!.addAnimation(group, forKey: "drawAnimation")
        CATransaction.commit()

    }
    
    private func resizePathToSize(path: CGPathRef, var size: CGSize) ->CGPathRef {
        let m = min(size.width, size.height)
        size = CGSizeMake(m ,m)
        let bezier: UIBezierPath = UIBezierPath(CGPath: path)
        var boundingBox = CGPathGetBoundingBox(path)
        //boundingBox.inset(dx: self.lineWidth, dy: self.lineWidth)
        let pathSize: CGSize = boundingBox.size
        if pathSize.width >= pathSize.height {
            bezier.applyTransform(CGAffineTransformMakeScale(size.width/pathSize.width, size.width/pathSize.width))
        }else{
            bezier.applyTransform(CGAffineTransformMakeScale(size.height/pathSize.height, size.height/pathSize.height))
        }
        bezier.applyTransform(CGAffineTransformMakeTranslation(self.lineWidth/2.0, self.lineWidth/2.0))
        
        //bezier.applyTransform(CGAffineTransformMakeScale(0.5, 0.5))
        return bezier.CGPath
    }
    
    private func resizePathToBounds(path: CGPathRef, rect: CGRect) ->CGPathRef {
        let m = min(rect.size.width, rect.size.height)
        let originalRect = rect
        //rect = CGRect(origin: rect.origin, size: CGSize(width: m, height: m))
        //rect.inset(dx: self.lineWidth/2.0, dy: self.lineWidth/2.0)
        //CGSizeMake( m - self.lineWidth, m - self.lineWidth)
        let size = rect.size
        let bezier: UIBezierPath = UIBezierPath(CGPath: path)
        var boundingBox = CGPathGetBoundingBox(path)
        let pathSize: CGSize = boundingBox.size
        
        if pathSize.width >= pathSize.height {
            bezier.applyTransform(CGAffineTransformMakeScale(size.width/pathSize.width, size.width/pathSize.width))
            
        }else{
            bezier.applyTransform(CGAffineTransformMakeScale(size.height/pathSize.height, size.height/pathSize.height))
        }
        bezier.applyTransform(CGAffineTransformMakeTranslation(self.lineWidth/2.0, self.lineWidth/2.0))
        //bezier.applyTransform(CGAffineTransformMakeScale(0.5, 0.5))
        return bezier.CGPath
    }
    
    override func layoutSubviews() {
        if let shapeLayer = self.shapeLayer {
            
            var rect = self.bounds
            
            rect.inset(dx: self.lineWidth/2.0, dy: self.lineWidth/2.0)
            shapeLayer.path = self.resizePathToSize(shapeLayer.path, size: rect.size)
            //shapeLayer.path = self.resizePathToBounds(shapeLayer.path, rect: rect)
            shapeLayer.frame = self.bounds
        }
    }
}
