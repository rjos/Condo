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
        return UIColor.rgba(88, g: 87, b: 208, a: 255)
    }
    static func condoQuestionBackgroundColor() ->UIColor {
        return UIColor.rgba(0, g: 154, b: 200, a: 255)
    }
    static func condoAnnouncementBackgroundColor() ->UIColor {
        return UIColor.rgba(220, g: 61, b: 52, a: 255)
    }
    static func condoCommentEvenBackgroundColor() ->UIColor {
        return UIColor.rgba(244, g: 244, b: 244, a: 255)
    }
    static func condoCommentOddBackgroundColor() ->UIColor {
        return UIColor.rgba(229, g: 229, b: 229, a: 255)
    }
    
    static func condoBlue() -> UIColor {
        return UIColor.rgba(75, g: 181, b: 198, a: 255)
    }
    
    static func condoYellow() -> UIColor {
        return UIColor.rgba(234, g: 186, b: 52, a: 255)
    }
    
    static func condoRed() -> UIColor {
        return UIColor.rgba(186, g: 81, b: 77, a: 255)
    }
    
    static func condoGreen() -> UIColor {
        return UIColor.rgba(129, g: 195, b: 134, a: 255)
    }
    
    static func condoPurple() -> UIColor {
        return UIColor.rgba(103, g: 78, b: 142, a: 255)
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

extension String{
    func toDouble() -> Double?{
        let number  = NSNumberFormatter().numberFromString(self)
        
        if let number = number {
            return number.doubleValue
        }
        
        return nil
    }
}

extension NSDate{
    var month: Int {
        get{
            let calendar = NSCalendar.currentCalendar()
            return calendar.component(NSCalendarUnit.MonthCalendarUnit, fromDate: self)
        }
    }
    var year: Int {
        get{
            let calendar = NSCalendar.currentCalendar()
            return calendar.component(NSCalendarUnit.YearCalendarUnit, fromDate: self)
        }
    }
    var day: Int {
        get{
            let calendar = NSCalendar.currentCalendar()
            return calendar.component(NSCalendarUnit.DayCalendarUnit, fromDate: self)
        }
    }
}