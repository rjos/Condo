//
//  CommunityFeedTableViewController.swift
//  Condo
//
//  Created by Lucas Tenório on 09/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel


class CommunityFeedTableViewController: UITableViewController {
    var community: Community?
    
    var selectedPost: Post? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.community = DummyDatabase().community
        self.tableView.registerNib(UINib(nibName: "CommunityFeedTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "post")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50.0
        self.tableView.reloadData()
        
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if let c = self.community {
            return c.posts.count()
        }
        return 0
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        cell.layoutSubviews()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("post", forIndexPath: indexPath) as! CommunityFeedTableViewCell
        cell.post = self.community!.posts.modelAtIndex(indexPath.row) as? Post
//        cell.layoutSubviews()
//        cell.setNeedsDisplay()
//        
//        cell.setNeedsLayout()
        return cell
    }


    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedPost = self.community?.posts.modelAtIndex(indexPath.row) as? Post
        self.performSegueWithIdentifier("showPost", sender: self)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPost" {
            let vc = segue.destinationViewController as! PostDetailTableViewController
            vc.post = self.selectedPost
        }
    }


}
