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
    
    var database: Array<Post> = []
    
    var selectedPost: Post? = nil
    
    @IBOutlet weak var btnShowNewPost: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.community = ParseDatabase.sharedDatabase.getCommunityUser() //DummyDatabase().community
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor.condoBlue30()
        self.refreshControl?.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.backgroundColor = UIColor.condoMainBackgroundColor()
        
        self.tableView.registerNib(UINib(nibName: "AnnouncementTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "announcement")
        self.tableView.registerNib(UINib(nibName: "ReportTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "report")
        self.tableView.registerNib(UINib(nibName: "QuestionTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "question")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50.0
        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
        self.navigationController?.navigationBar.barTintColor = UIColor.condoNavigationBarColor()
        self.tabBarController?.tabBar.tintColor = UIColor.blueColor()
    }
    
    func refreshData(){
        
        if let refreshControll = self.refreshControl {
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            if let community = self.community {
                
                ParseDatabase.sharedDatabase.getAllPosts(community: community, completionBlock: { (posts, error) -> () in
                    if let posts = posts {
                        self.database = posts
                        self.tableView.reloadData()
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    }
                })
            }
            
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        if let community = self.community {
            
            ParseDatabase.sharedDatabase.getAllPosts(community: community) { (posts, error) -> () in
                if let posts = posts {
                    self.database = posts
                    self.tableView.reloadData()
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //if let db = self.database {
            return database.count
        //}
        //return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("post", forIndexPath: indexPath) as! CommunityFeedTableViewCell
        let post: Post = self.database[indexPath.row]//self.database!.allPosts().modelAtIndex(indexPath.row) as! Post
        let cell: UITableViewCell
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


    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedPost = self.database[indexPath.row] //self.database!.allPosts().modelAtIndex(indexPath.row) as? Post
        self.performSegueWithIdentifier("showPost", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPost" {
            let vc = segue.destinationViewController as! PostDetailTableViewController
            vc.post = self.selectedPost
        }else if segue.identifier == "showNewPost" {
            let vc = segue.destinationViewController as! NewPostViewController
            vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        }
    }


}
