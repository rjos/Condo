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
    var strokeColor = UIColor.blueColor() {
        didSet{
            self.applyPropertiesToShape()
        }
    }
    var fillColor = UIColor.clearColor() {
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
        self.applyPropertiesToShape()
        self.layer.addSublayer(self.shapeLayer)
    }
    private func applyPropertiesToShape(){
        self.shapeLayer!.strokeColor = self.strokeColor.CGColor
        self.shapeLayer!.fillColor = self.onlyFillAfterAnimation ? UIColor.clearColor().CGColor : self.fillColor.CGColor
        self.shapeLayer!.lineWidth = self.lineWidth;
        self.shapeLayer!.frame = self.bounds;
        self.shapeLayer!.strokeEnd = self.onlyStrokeAfterAnimation ? 0.0 : 1.0
    }
    func animateShape() {
        CATransaction.begin()
//        if self.onlyFillAfterAnimation {
//            self.shapeLayer?.fillColor = UIColor.clearColor().CGColor
//        }
        self.onlyStrokeAfterAnimation = false
        self.onlyFillAfterAnimation = false
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
//            self.shapeLayer?.fillColor = self.fillColor.CGColor
//            self.shapeLayer?.strokeEnd = 1.0
        }
        
        self.shapeLayer!.addAnimation(group, forKey: "drawAnimation")
        CATransaction.commit()
    }
    
    private func resizePathToSize(path: CGPathRef, size: CGSize) ->CGPathRef {
        let bezier: UIBezierPath = UIBezierPath(CGPath: path)
        let pathSize: CGSize = CGPathGetBoundingBox(path).size
        if pathSize.width > pathSize.height {
            bezier.applyTransform(CGAffineTransformMakeScale(size.width/pathSize.width, size.width/pathSize.width))
        }else{
            bezier.applyTransform(CGAffineTransformMakeScale(size.height/pathSize.height, size.height/pathSize.height))
        }
        return bezier.CGPath
    }
    
    override func layoutSubviews() {
        if let shapeLayer = self.shapeLayer {
            shapeLayer.path = self.resizePathToSize(shapeLayer.path, size: self.bounds.size)
        }
    }
}
