//
//  NewPostViewController.swift
//  Condo
//
//  Created by Rodolfo José on 11/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {

    @IBOutlet weak var typeUser: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ShowBack(sender: AnyObject) {
    }

    @IBAction func ShowPublish(sender: AnyObject) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
