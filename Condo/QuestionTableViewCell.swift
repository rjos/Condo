//
//  QuestionTableViewCell.swift
//  Condo
//
//  Created by Lucas Tenório on 10/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var disagreeButton: UIButton!
    @IBOutlet weak var agreeImageView: UIImageView!
    @IBOutlet weak var disagreeImageView: UIImageView!
    @IBOutlet weak var agreeLabel: UILabel!
    @IBOutlet weak var disagreeLabel: UILabel!
    
    let deselectedImageViewTransform = CGAffineTransformMakeScale(0.0, 0.0)
    let selectedImageViewTransform = CGAffineTransformIdentity
    
    var postHolder: PostView? = nil
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.postHolder = PostView.instantiateWithOwner(self)
        self.postView.fillWithSubview(postHolder!)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.contentView.backgroundColor = UIColor.condoMainBackgroundColor()
        self.mainView.backgroundColor = UIColor.condoQuestionBackgroundColor()
        self.agreeButton.backgroundColor = UIColor.condoQuestionBackgroundColor()
        self.disagreeButton.backgroundColor = UIColor.condoQuestionBackgroundColor()
        self.agreeImageView.transform = deselectedImageViewTransform
        self.disagreeImageView.transform = deselectedImageViewTransform
        // Initialization code
    }

    var post: Post? = nil {
        didSet{
            let properties = PostDrawingProperties(type: self.post!.type)
            let outlineColor = properties.outlineColor
            self.postHolder!.post = self.post
            self.postHolder!.textColor = UIColor.whiteColor()
            
            self.mainView.layer.cornerRadius = properties.cornerRadius
            self.mainView.layer.borderWidth = properties.lineWidth
            self.mainView.layer.borderColor = UIColor.clearColor().CGColor
            self.mainView.layer.masksToBounds = true
            
            self.tintColor = outlineColor
        }
    }
    
    func showAgree(){
        self.agreeImageView.transform = deselectedImageViewTransform
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.agreeImageView.transform = self.selectedImageViewTransform
        }) { (completed) -> Void in
            self.showingAgree = true
        }
    }
    
    func hideAgree() {
        self.agreeImageView.transform = selectedImageViewTransform
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.agreeImageView.transform = self.deselectedImageViewTransform
            }) { (completed) -> Void in
                self.showingAgree = false
        }
    }
    
    
    var showingAgree = false
    @IBAction func agreeButtonPressed(sender: AnyObject) {
        if self.showingAgree {
            hideAgree()
        }else{
            self.showAgree()
        }
    }
    
    @IBAction func disagreeButtonPressed(sender: AnyObject) {
        
    }
    
}
