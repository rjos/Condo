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
        return UIColor.condoBlue()
    }
    static func condoQuestionBackgroundColor() ->UIColor {
        return UIColor.rgba(85, g: 196, b: 132, a: 255)
    }
    static func condoAnnouncementBackgroundColor() ->UIColor {
        return UIColor.rgba(213, g: 80, b: 76, a: 255)
    }
    static func condoCommentEvenBackgroundColor() ->UIColor {
        return UIColor.rgba(255, g: 255, b: 255, a: 255)
    }
    static func condoCommentOddBackgroundColor() ->UIColor {
        return UIColor.rgba(247, g: 247, b: 247, a: 255)
    }
    
    static func condoBlue() -> UIColor {
        return UIColor.rgba(0, g: 182, b: 200, a: 255)
    }
    
    static func condoBlue30() -> UIColor {
        return UIColor.rgba(0, g: 182, b: 200, a: 76)
    }
    
    static func condoBlue60() -> UIColor {
        return UIColor.rgba(0, g: 182, b: 200, a: 153)
    }
    
    static func condoBlue80() -> UIColor {
        return UIColor.rgba(0, g: 182, b: 200, a: 204)
    }
    
    static func condoYellow() -> UIColor {
        return UIColor.rgba(250, g: 187, b: 26, a: 255)
    }
    
    static func condoRed() -> UIColor {
        return UIColor.rgba(213, g: 80, b: 76, a: 255)
    }
    
    static func condoGreen() -> UIColor {
        return UIColor.rgba(85, g: 196, b: 132, a: 255)
    }
    
    static func condoPurple() -> UIColor {
        return UIColor.rgba(112, g: 77, b: 145, a: 255)
    }
    
    static func condoMainBackgroundColor() -> UIColor{
        return UIColor.whiteColor()
    }
    
    static func condoNavigationBarColor() -> UIColor {
        return UIColor.rgba(247, g: 247, b: 247, a: 255)
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
    
    var lastyear: NSDate {
        get{
            let calendar = NSCalendar.currentCalendar()
            let offsetComponents = NSDateComponents()
            offsetComponents.year = -1
            return calendar.dateByAddingComponents(offsetComponents, toDate: self, options: NSCalendarOptions.allZeros)!
        }
    }
    var month: Int {
        get{
            let calendar = NSCalendar.currentCalendar()
            return calendar.component(.CalendarUnitMonth, fromDate: self)
        }
    }
    var year: Int {
        get{
            let calendar = NSCalendar.currentCalendar()
            return calendar.component(.CalendarUnitYear, fromDate: self)
        }
    }
    var day: Int {
        get{
            let calendar = NSCalendar.currentCalendar()
            return calendar.component(.CalendarUnitDay, fromDate: self)
        }
    }
}

class NotificationManager {
    private var observerTokens: [AnyObject] = []
    
    deinit {
        deregisterAll()
    }
    
    func deregisterAll() {
        for token in observerTokens {
            NSNotificationCenter.defaultCenter().removeObserver(token)
        }
        
        observerTokens = []
    }
    
    func registerObserver(name: String!, block: (NSNotification! -> Void)) {
        let newToken = NSNotificationCenter.defaultCenter().addObserverForName(name, object: nil, queue: nil) {note in
            block(note)
        }
        
        observerTokens.append(newToken)
    }
    
    func registerObserver(name: String!, forObject object: AnyObject!, block: (NSNotification! -> Void)) {
        let newToken = NSNotificationCenter.defaultCenter().addObserverForName(name, object: object, queue: nil) {note in
            block(note)
        }
        
        observerTokens.append(newToken)
    }
}

