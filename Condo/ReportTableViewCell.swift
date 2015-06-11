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
        self.mainView.backgroundColor = UIColor.condoReportBackgroundColor()
        self.mainView.layer.cornerRadius = 15.0
        self.mainView.layer.masksToBounds = true
    }
    
    var post: Post? = nil {
        didSet{
            self.postView!.post = self.post
        }
    }
    
}
