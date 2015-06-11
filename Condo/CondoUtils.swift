//
//  Extensions.swift
//  Condo
//
//  Created by Lucas Tenório on 10/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)->UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a/255.0)
    }
    static func condoReportBackgroundColor() ->UIColor {
        return UIColor.rgba(255, g: 64, b: 0, a: 255)
    }
    static func condoQuestionBackgroundColor() ->UIColor {
        return UIColor.rgba(6, g: 38, b: 204, a: 255)
    }
    static func condoAnnouncementBackgroundColor() ->UIColor {
        return UIColor.rgba(98, g: 111, b: 178, a: 255)
    }
    static func condoCommentEvenBackgroundColor() ->UIColor {
        return UIColor.rgba(51, g: 51, b: 51, a: 255)
    }
    static func condoCommentOddBackgroundColor() ->UIColor {
        return UIColor.rgba(200, g: 200, b: 200, a: 255)
    }
}

extension UIView {
    func fillWithSubview(subview: UIView) {
        subview.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(subview)
        let constraint1 = NSLayoutConstraint(
            item: subview,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Right,
            multiplier: 1,
            constant: 0)
        
        let constraint2 = NSLayoutConstraint(
            item: subview,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Bottom,
            multiplier: 1,
            constant: 0)
        
        let constraint3 = NSLayoutConstraint(
            item: subview,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Left,
            multiplier: 1,
            constant: 0)
        
        let constraint4 = NSLayoutConstraint(
            item: subview,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Top,
            multiplier: 1,
            constant: 0)
        
        self.addConstraints([constraint1,constraint2,constraint3,constraint4])
    }
}
