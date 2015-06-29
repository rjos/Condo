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
    let notificationManager = NotificationManager()
    var community: Community?
    
    var database: Array<Post> = []
    
    var selectedPost: Post? = nil
    
    @IBOutlet weak var btnShowNewPost: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.community = ParseDatabase.sharedDatabase.getCommunityUser()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor.condoBlue30()
        self.refreshControl?.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.backgroundColor = UIColor.condoMainBackgroundColor()
        
        self.tableView.registerNib(UINib(nibName: "AnnouncementTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "announcement")
        self.tableView.registerNib(UINib(nibName: "ReportTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "report")
        self.tableView.registerNib(UINib(nibName: "QuestionTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "question")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50.0
        
        self.notificationManager.registerObserver(FeedController.NotificationNewData) {
            (notification) in
            self.database = FeedController.sharedController.posts
            if let r = self.refreshControl where r.refreshing{
                r.endRefreshing()
            }
            self.tableView.reloadData()
        }
        
        self.notificationManager.registerObserver(FeedController.NotificationNewComment) {
            (notification) in
            self.database = FeedController.sharedController.posts
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
        self.navigationController?.navigationBar.barTintColor = UIColor.condoNavigationBarColor()
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.condoBlue()
        self.tabBarController?.tabBar.tintColor = UIColor.condoBlue()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.condoBlue()]
    }
    
    func refreshData(){
        FeedController.sharedController.reloadData()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidAppear(animated: Bool) {
        if !FeedController.sharedController.hasData {
            self.refreshData()
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return database.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post: Post = self.database[indexPath.row]
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
            qCell.post = post as? PostQuestion
            cell = qCell
        }
        return cell
    }

    @IBAction func newPostButtonPressed(sender: AnyObject) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "Nova pergunta", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.performSegueWithIdentifier("showNewQuestion", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Novo problema", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.performSegueWithIdentifier("showNewPost", sender: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Novo aviso", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.performSegueWithIdentifier("showNewAnnouncement", sender: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
        }))
        self.presentViewController(alert, animated: true, completion: nil)

    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedPost = self.database[indexPath.row]
        self.performSegueWithIdentifier("showPost", sender: self)
    }
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPost" {
            let vc = segue.destinationViewController as! PostDetailTableViewController
            vc.post = self.selectedPost
        }else if segue.identifier == "showNewPost" {
            let vc = segue.destinationViewController as! NewPostViewController
            vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            vc.type = PostContentType.Report
        }else if segue.identifier == "showNewAnnouncement" {
            let vc = segue.destinationViewController as! NewPostViewController
            vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            vc.type = PostContentType.Announcement
        }else if segue.identifier == "showNewQuestion" {
            let vc = segue.destinationViewController as! NewPostViewController
            vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            vc.type = PostContentType.Question
        }
    }
}
