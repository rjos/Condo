//
//  CommunityFeedTableViewCell.swift
//  Condo
//
//  Created by Lucas Tenório on 09/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//



import UIKit
import CondoModel


class CommunityFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPhotoImageView: UIImageView!

    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    var post: Post? {
        didSet{
            if let post = self.post {
                self.userPhotoImageView.layer.cornerRadius = self.userPhotoImageView.bounds.size.width/2
                self.userPhotoImageView.clipsToBounds = true
                self.mainView.layer.cornerRadius = 8.0
                switch(post.type){
                case(PostContentType.Announcement): self.mainView.backgroundColor = UIColor.condoAnnouncementBackgroundColor()
                case(PostContentType.Question): self.mainView.backgroundColor = UIColor.condoQuestionBackgroundColor()
                case(PostContentType.Report): self.mainView.backgroundColor = UIColor.condoReportBackgroundColor()
                }
                self.userPhotoImageView.image = UIImage(named: post.owner.imageName)
                self.postTextLabel.text = post.text
                self.userNameLabel.text = post.owner.name
                self.commentCountLabel.text = "\(post.comments.count()) comentários"
            }
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
