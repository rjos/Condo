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
    }

    var answerStatus: AnswerStatus  = AnswerStatus.NoAnswer {
        didSet{
            let deselectedImageViewTransform = CGAffineTransformMakeScale(0.4, 0.4)
            let selectedImageViewTransform = CGAffineTransformIdentity
            switch self.answerStatus {
            case .NoAnswer:
                self.agreeImageView.transform = deselectedImageViewTransform
                self.agreeImageView.alpha = 0.0
                self.disagreeImageView.transform = deselectedImageViewTransform
                self.disagreeImageView.alpha = 0.0
            case .Agree:
                self.agreeImageView.transform = selectedImageViewTransform
                self.agreeImageView.alpha = 1.0
                self.disagreeImageView.transform = deselectedImageViewTransform
                self.disagreeImageView.alpha = 0.0
            case .Disagree:
                self.agreeImageView.transform = deselectedImageViewTransform
                self.agreeImageView.alpha = 0.0
                self.disagreeImageView.transform = selectedImageViewTransform
                self.disagreeImageView.alpha = 1.0
            }
        }
    }
    
    var agreeIncrement: Int {
        get {
            if self.answerStatus == AnswerStatus.Agree{
                return 1
            }else{
                return 0
            }
        }
    }
    
    var disagreeIncrement: Int {
        get {
            if self.answerStatus == AnswerStatus.Disagree{
                return 1
            }else{
                return 0
            }
        }
    }
    
    

    func reloadCounters(){
        self.disagreeLabel.text = "\(self.post!.totalDisagree + self.disagreeIncrement)"
        self.agreeLabel.text = "\(self.post!.totalAgree + self.agreeIncrement)"
    }
    
    var post: PostQuestion? = nil {
        didSet{
            let properties = PostDrawingProperties(type: self.post!.type)
            let outlineColor = properties.outlineColor
            self.postHolder!.post = self.post
            self.postHolder!.textColor = UIColor.whiteColor()
            
            self.mainView.layer.cornerRadius = properties.cornerRadius
            self.mainView.layer.borderWidth = properties.lineWidth
            self.mainView.layer.borderColor = UIColor.clearColor().CGColor
            self.mainView.layer.masksToBounds = true
            self.answerStatus = FeedController.sharedController.getAnswerStatus(question: self.post!)
            self.reloadCounters()
            self.tintColor = outlineColor
        }
    }

    @IBAction func agreeButtonPressed(sender: AnyObject) {
        let nextStatus: AnswerStatus
        if self.answerStatus == AnswerStatus.Agree {
            nextStatus = AnswerStatus.NoAnswer
        }else{
            nextStatus = AnswerStatus.Agree
        }
        self.changeStatus(nextStatus)
    }
    
    @IBAction func disagreeButtonPressed(sender: AnyObject) {
        let nextStatus: AnswerStatus
        if self.answerStatus == AnswerStatus.Disagree {
            nextStatus = AnswerStatus.NoAnswer
        }else{
            nextStatus = AnswerStatus.Disagree
        }
        self.changeStatus(nextStatus)
    }
    func changeStatus(newStatus: AnswerStatus) {
        FeedController.sharedController.setAnswerStatus(question: self.post!, status: newStatus)
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.answerStatus = newStatus
            self.reloadCounters()
            }, completion: nil)
    }
}
