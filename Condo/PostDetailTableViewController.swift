//
//  PostDetailTableViewController.swift
//  Condo
//
//  Created by Lucas Tenório on 10/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

class PostDetailTableViewController: SLKTextViewController {

    var post: Post?
    
    var database: Array<Comment> = []
    
    override class func tableViewStyleForCoder(decoder: NSCoder) -> UITableViewStyle {
        return UITableViewStyle.Plain;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inverted = false
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.tableView.registerNib(UINib(nibName: "AnnouncementTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "announcement")
        self.tableView.registerNib(UINib(nibName: "ReportTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "report")
        self.tableView.registerNib(UINib(nibName: "QuestionTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "question")
        
        self.tableView.registerNib(UINib(nibName: "CommunityFeedTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "post")
        self.tableView.registerNib(UINib(nibName: "CommentTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "comment")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        self.textInputbar.translucent = false
        self.rightButton.setTitle("Enviar", forState: .Normal)
        self.rightButton.addTarget(self, action: "sendComment:", forControlEvents: UIControlEvents.TouchDown)
        self.tableView.reloadData()
    }

    override func viewDidAppear(animated: Bool) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        ParseDatabase.sharedDatabase.getCommentFromPost(self.post!, completionBlock: { (comments, error) -> () in
            
            if let comments = comments {
             
                self.database = comments
                self.tableView.reloadData()
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        })   
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        if let post = self.post {
            return 2
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let post = self.post {
            if section == 0 {
                return 1
            }else{
                return self.database.count//post.totalComments
            }
        }
        return 0
    }
    
    func postCell()->UITableViewCell {
        
        let cell: UITableViewCell
        let post = self.post!
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        switch (post.type) {
        case (.Announcement):
            let aCell = tableView.dequeueReusableCellWithIdentifier("announcement", forIndexPath: indexPath) as! AnnouncementTableViewCell
            aCell.post = post
            cell = aCell
        case (.Report):
            let rCell = tableView.dequeueReusableCellWithIdentifier("report", forIndexPath: indexPath) as! ReportTableViewCell
            rCell.post = post
            cell = rCell
        case (.Question):
            let qCell = tableView.dequeueReusableCellWithIdentifier("question", forIndexPath: indexPath) as! QuestionTableViewCell
            qCell.post = post
            cell = qCell
        }
        return cell
    }

    func commentCell(indexPath: NSIndexPath) -> CommentTableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("comment", forIndexPath: indexPath) as! CommentTableViewCell
        cell.comment = self.database[indexPath.row] as Comment
        //self.post!.comments.modelAtIndex(indexPath.row) as? Comment
        cell.isEven = indexPath.row % 2 == 0
        let draw = PostDrawingProperties(type: self.post!.type)
        cell.lbName.textColor = draw.outlineColor
        cell.lbComment.textColor = draw.outlineColor
        return cell
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return self.postCell()
        }else{
            return self.commentCell(indexPath)
        }
    }
    
    func sendComment(sender: UIButton!){
        
        let user = ParseDatabase.sharedDatabase.getCurrentUser()
        
        let message = self.textView.text
        
        if count(message) > 0 {
            ParseDatabase.sharedDatabase.createComment(owner: user, text: message, post: self.post!) { (comment, error) -> () in
                
                if let comment = comment {
                    
                    self.database.append(comment)
                    
                    self.tableView.reloadData()
                    
                }else{
                    println(error)
                }
            }
        }
    }
}
