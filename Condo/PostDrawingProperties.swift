//
//  PostDrawingProperties.swift
//  Condo
//
//  Created by Lucas Tenório on 16/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

struct PostDrawingProperties {
    let outlineColor: UIColor
    let lineWidth: CGFloat
    let imageIconName: String
    let cornerRadius: CGFloat
    let type: PostContentType
    init(type: PostContentType) {
        self.type = type
        self.cornerRadius = 15.0
        
        switch self.type {
        case PostContentType.Announcement:
            self.outlineColor = UIColor.condoAnnouncementBackgroundColor()
            self.lineWidth = 2.0
            self.imageIconName = ""
        case PostContentType.Question:
            self.outlineColor = UIColor.condoQuestionBackgroundColor()
            self.lineWidth = 2.0
            self.imageIconName = ""
        case PostContentType.Report:
            self.outlineColor = UIColor.condoReportBackgroundColor()
            self.lineWidth = 2.0
            self.imageIconName = ""
        }
    }
}