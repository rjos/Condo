//
//  CommentTableViewCell.swift
//  Condo
//
//  Created by Rodolfo José on 10/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbComment: UILabel!
    @IBOutlet weak var bgComment: UIView!
    
    var isEven : Bool = true {
        didSet {
            switch (self.isEven){
            case true:
                self.bgComment.backgroundColor = UIColor.condoCommentEvenBackgroundColor()
            default:
                self.bgComment.backgroundColor = UIColor.condoCommentOddBackgroundColor()
            }
        }
    }
    
    var comment: Comment?{
        didSet{
            if let comment = self.comment{
                self.bgComment.layer.cornerRadius = 15.0
                self.imgProfile.layer.cornerRadius = self.imgProfile.bounds.size.width / 2
                self.imgProfile.clipsToBounds = true
                self.imgProfile.image = UIImage(named: comment.owner.imageName)
                self.lbName.text      = comment.owner.name
                self.lbComment.text   = comment.text
//                self.lbComment.sizeToFit()
//                self.bgComment.layoutSubviews()
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //override func setSelected(selected: Bool, animated: Bool) {
    //    super.setSelected(selected, animated: animated)
    //
        // Configure the view for the selected state
    //}
    
}
