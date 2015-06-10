//
//  PostView.swift
//  Condo
//
//  Created by Lucas Tenório on 10/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel
@IBDesignable
class PostView: UIView {
    
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var nextImageView: UIImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBInspectable var cornerRadius: CGFloat = 0.0{
        didSet{
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = cornerRadius != 0.0
        }
    }
    override func translatesAutoresizingMaskIntoConstraints() -> Bool {
        return false
    }
    var post: Post? {
        didSet{
            if let post = self.post {
                self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width/2
                self.userImageView.clipsToBounds = true
                switch(post.type){
                case(PostContentType.Announcement):
                    self.backgroundColor = UIColor.condoAnnouncementBackgroundColor()
                    
                case(PostContentType.Question):
                    self.backgroundColor = UIColor.condoQuestionBackgroundColor()
                    
                case(PostContentType.Report):
                    self.backgroundColor = UIColor.condoReportBackgroundColor()
                    
                }
                self.userImageView.image = UIImage(named: post.owner.imageName)
                self.postTextLabel.text = post.text
                self.userNameLabel.text = post.owner.name
                self.commentCountLabel.text = "\(post.comments.count()) comentários"
            }
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
