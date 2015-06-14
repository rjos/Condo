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
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.registerNib(UINib(nibName: "ExpenseCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView?.reloadData()
        let first = NSIndexPath(forItem: 0, inSection: 0)
        self.collectionView!.selectItemAtIndexPath(first, animated: true, scrollPosition: UICollectionViewScrollPosition.None)
        self.collectionView(self.collectionView!, didSelectItemAtIndexPath: first)
        self.title = DummyDatabase().community.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var selectedType = ExpenseType.allValues[0] {
        didSet{
            
            var p = ExpenseDrawingProperties(type: self.selectedType)
//            let header = self.collectionView?.viewWithTag(666) as? ExpenseHeaderReusableView
//            header?.expenseProperties = p
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
        return ExpenseType.allValues.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ExpenseCollectionViewCell
        let type = ExpenseType.allValues[indexPath.row % ExpenseType.allValues.count]
        cell.expenseProperties = ExpenseDrawingProperties(type: type)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedType = ExpenseType.allValues[indexPath.row]
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
