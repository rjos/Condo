//
//  PostDetailTableViewController.swift
//  Condo
//
//  Created by Lucas Tenório on 10/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel
class PostDetailTableViewController: UITableViewController {

    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "AnnouncementTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "announcement")
        self.tableView.registerNib(UINib(nibName: "ReportTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "report")
        self.tableView.registerNib(UINib(nibName: "QuestionTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "question")
        
        self.tableView.registerNib(UINib(nibName: "CommunityFeedTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "post")
        self.tableView.registerNib(UINib(nibName: "CommentTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "comment")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        //self.tableView.reloadData()
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
                return post.comments.count()
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
        cell.comment = self.post!.comments.modelAtIndex(indexPath.row) as? Comment
        cell.isEven = indexPath.row % 2 == 0
        return cell
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return self.postCell()
        }else{
            return self.commentCell(indexPath)
        }
    }
}
