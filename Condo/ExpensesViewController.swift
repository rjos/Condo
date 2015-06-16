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
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var expenseGraphViewController: ExpenseGraphViewController? = nil
    
    var allExpenses: Array<Expense>? = nil
    var expenseDictionary: Dictionary<ExpenseType, Array<Expense>> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.registerNib(UINib(nibName: "ExpenseCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "cell")
        

        self.title = DummyDatabase().community.name
        
        self.fetchData()
        // Do any additional setup after loading the view.
    }
    
    func fetchData() {
        let community = ParseDatabase.sharedDatabase.testCommunity()
        ParseDatabase.sharedDatabase.getAllExpenses(community: community) { (expenses, error) -> () in
            if let expenses = expenses {
                self.allExpenses = expenses
                self.expenseDictionary = [:]
                for expense in expenses {
                    let type = expense.type
                    var expenseArray: Array<Expense>
                    if let array = self.expenseDictionary[type] {
                        expenseArray = array
                    } else {
                        expenseArray = []
                    }
                    expenseArray.append(expense)
                    self.expenseDictionary[type] = expenseArray
                }
                self.collectionView?.reloadData()
                let first = NSIndexPath(forItem: 0, inSection: 0)
                if self.expenseDictionary.count > 0 {
                    self.collectionView!.selectItemAtIndexPath(first, animated: true, scrollPosition: UICollectionViewScrollPosition.None)
                    self.collectionView(self.collectionView!, didSelectItemAtIndexPath: first)
                }
            }
        }
    }
    
    var selectedType = ExpenseType.allValues[0] {
        didSet{
            
            var p = ExpenseDrawingProperties(type: self.selectedType)
            self.expenseGraphViewController?.expenses = self.expenseDictionary[self.selectedType]!
            self.expenseGraphViewController?.selectedType = self.selectedType
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
            self.navigationController?.navigationBar.barTintColor = p.selectedBackgroundColor
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
            //self.tabBarController?.tabBar.barTintColor = p.selectedBackgroundColor
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
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
