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
    
    @IBOutlet weak var postIconImageView: UIImageView!
    @IBOutlet weak var nextImageViewWidth: NSLayoutConstraint!
    static func instantiateWithOwner(owner: AnyObject!) ->PostView{
        let nib = UINib(nibName: "PostView", bundle: nil)
        let nibs = nib.instantiateWithOwner(owner, options:nil)
        return nibs.first as! PostView
    }
    var nextImageHidden: Bool = true{
        didSet {
            if self.nextImageHidden{
                self.nextImageViewWidth.constant = 0.0
            }else{
                self.nextImageViewWidth.constant = 30.0
            }
        }
    }
    var textColor = UIColor.whiteColor() {
        didSet{
            self.postTextLabel.textColor = self.textColor
            self.userNameLabel.textColor = self.textColor
            self.commentCountLabel.textColor = self.textColor
        }
    }
    var post: Post? {
        didSet{
            if let post = self.post {
                self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width/2
                self.userImageView.clipsToBounds = true
                self.userImageView.image = UIImage(named: post.owner.imageName)
                self.postTextLabel.text = post.text
                self.userNameLabel.text = post.owner.name
                if post.totalComments == 0 {
                    self.commentCountLabel.text = "Sem comentários"
                }else if post.totalComments == 1 {
                    self.commentCountLabel.text = "\(post.totalComments) comentário"
                } else {
                    self.commentCountLabel.text = "\(post.totalComments) comentários"
                }
                self.nextImageHidden = true
                let properties = PostDrawingProperties(type: self.post!.type)
                let imageName = properties.imageIconName
                self.postIconImageView.image = UIImage(named: imageName)
                self.layoutSubviews()
            }
        }
    }
}
