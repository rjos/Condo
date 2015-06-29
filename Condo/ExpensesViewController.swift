//
//  ExpensesViewController.swift
//  Condo
//
//  Created by Lucas Tenório on 14/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

class ExpensesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let notificationManager = NotificationManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var btnRefresh: UIBarButtonItem!
    @IBOutlet weak var btnOrganize: UIBarButtonItem!
    
    var expenseGraphViewController: ExpenseGraphViewController? = nil
    
    var allExpenses: Array<Expense>? = nil
    var expenseDictionary: Dictionary<ExpenseType, Array<Expense>> = [:]
    
    var titleView = UILabel(frame: CGRectMake(0, 0, 320, 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.registerNib(UINib(nibName: "ExpenseCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "cell")
        
        //self.title = DummyDatabase().community.name
        
        self.loadData()
        self.notificationManager.registerObserver(ExpensesController.DataChangedNotification) {
            [weak self](notification) in
            self?.expensesChanged(notification)
        }
        ExpensesController.sharedController.reloadData(cached: true)
        
        self.titleView.font = UIFont.boldSystemFontOfSize(18)
        self.titleView.backgroundColor = UIColor.clearColor()
        self.titleView.text = ParseDatabase.sharedDatabase.getCommunityUser().name //DummyDatabase().community.name
        self.titleView.textAlignment = NSTextAlignment.Center
    }
    
    func expensesChanged(notification: NSNotification) {
        loadData()
    }
    func loadData() {
        self.expenseDictionary = ExpensesController.sharedController.expenseDictionary
        self.collectionView?.reloadData()
        let first = NSIndexPath(forItem: 0, inSection: 0)
        if self.expenseDictionary.count > 0 {
            self.collectionView!.selectItemAtIndexPath(first, animated: true, scrollPosition: UICollectionViewScrollPosition.None)
            self.collectionView(self.collectionView!, didSelectItemAtIndexPath: first)
        }
    }
    
    @IBAction func refreshButtonPressed(sender: UIBarButtonItem) {
        ExpensesController.sharedController.reloadData(cached: false)
    }
    
    var selectedType = ExpenseType.allValues[0] {
        didSet{
            
            var p = ExpenseDrawingProperties(type: self.selectedType)
            self.expenseGraphViewController?.expenses = self.expenseDictionary[self.selectedType]!
            self.expenseGraphViewController?.selectedType = self.selectedType
            /*self.navigationController?.navigationBar.barStyle = UIBarStyle.Black*/
            UIView.animateWithDuration(0.5) {
                //self.navigationController?.navigationBar.barTintColor = p.selectedBackgroundColor
                self.btnRefresh.tintColor = p.selectedBackgroundColor
                self.btnOrganize.tintColor = p.selectedBackgroundColor
                self.navigationController?.navigationBar.tintColor = p.selectedBackgroundColor
                self.tabBarController?.tabBar.tintColor = p.selectedBackgroundColor
                self.navigationController?.navigationItem.titleView?.tintColor = p.selectedBackgroundColor
                
                self.titleView.textColor = p.selectedBackgroundColor
                self.navItem.titleView = self.titleView
            }
            
            /*self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            self.navigationController?.navigationBar.shadowImage = UIImage()*/
            
            
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.expenseDictionary.count
    }
    
    func expenseType(#indexPath: NSIndexPath) -> ExpenseType {
        let index = indexPath.row
        return self.expenseDictionary.keys.array[index]
    }
    

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ExpenseCollectionViewCell
        let type = self.expenseType(indexPath: indexPath)
        cell.expenseProperties = ExpenseDrawingProperties(type: type)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedType = self.expenseType(indexPath: indexPath)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let visibleCells = self.collectionView?.visibleCells() as? Array<ExpenseCollectionViewCell>
        
        if let v = visibleCells {
            for cell in v{
                cell.expenseView.animateShape()
            }
        }
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let segueName = segue.identifier
        if segueName == "ExpenseGraphViewControllerSegue" {
            expenseGraphViewController = segue.destinationViewController as? ExpenseGraphViewController
        }
        let type = self.selectedType
        let p = ExpenseDrawingProperties(type: type)
        
        if let vc = segue.destinationViewController as? UIViewController {
            vc.view.tintColor = p.backgroundColor
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

}
