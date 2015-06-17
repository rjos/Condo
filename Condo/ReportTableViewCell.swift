//
//  ReportTableViewCell.swift
//  Condo
//
//  Created by Lucas Tenório on 10/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

class ReportTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    var postView: PostView? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.postView = PostView.instantiateWithOwner(self)
        self.mainView.fillWithSubview(postView!)
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    var post: Post? = nil {
        didSet{
            
            let properties = PostDrawingProperties(type: self.post!.type)
            let outlineColor = properties.outlineColor
            self.postView!.post = self.post
            self.postView!.textColor = outlineColor
            self.mainView.layer.cornerRadius = properties.cornerRadius
            self.mainView.layer.borderWidth = properties.lineWidth
            self.mainView.layer.borderColor = outlineColor.CGColor
            self.mainView.backgroundColor = UIColor.clearColor()
            self.mainView.layer.masksToBounds = true
        }
    }
    
}
