//
//  ExpensesCollectionViewController.swift
//  Condo
//
//  Created by Lucas Tenório on 11/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel
let reuseIdentifier = "expense"

class ExpensesCollectionViewController: UICollectionViewController {

    var selectedType = ExpenseType.allValues[0]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerNib(UINib(nibName: "ExpenseCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: reuseIdentifier)
        let first = NSIndexPath(forItem: 0, inSection: 0)
        self.collectionView!.selectItemAtIndexPath(first, animated: true, scrollPosition: UICollectionViewScrollPosition.None)
        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var view: UICollectionReusableView? = nil
        if kind == UICollectionElementKindSectionHeader {
            let expensesHeader: ExpenseHeaderReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as! ExpenseHeaderReusableView
            expensesHeader.tag = 666
            expensesHeader.expenseProperties = ExpenseDrawingProperties(type: self.selectedType)
            view = expensesHeader
        }
        return view!
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ExpenseType.allValues.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ExpenseCollectionViewCell
        let type = ExpenseType.allValues[indexPath.row % ExpenseType.allValues.count]
        cell.expenseProperties = ExpenseDrawingProperties(type: type)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedType = ExpenseType.allValues[indexPath.row]
        let header = self.collectionView?.viewWithTag(666) as? ExpenseHeaderReusableView
        var p = ExpenseDrawingProperties(type: self.selectedType)
        header?.expenseProperties = p
    }
    override func viewWillAppear(animated: Bool) {
        let visibleCells = self.collectionView?.visibleCells()
        if let v = visibleCells {
            for cell in v{
                if let cell = cell as? ExpenseCollectionViewCell {
                    cell.expenseView.animateShape()
                }
            }
        }
       
    }
    
//    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
//        if let cell = cell as? ExpenseCollectionViewCell {
//            cell.expenseView.animateShape()
//        }
//    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
