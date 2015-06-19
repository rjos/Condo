//
//  TestParseViewController.swift
//  Condo
//
//  Created by Rodolfo José on 15/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

class TestParseViewController: UIViewController {

    @IBOutlet weak var nameCommunity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveCommunity(sender: AnyObject) {
        
        /*ParseDatabase.sharedDatabase.createCommunity(nameCommunity.text, administratorID: "1234") { (community, error) -> () in
        if let error = error {
        println(error)
        }else{
        println("Funcionou!!!!")
        }
        }*/
        
        let community = ParseDatabase.sharedDatabase.getCommunityUser()
        
        let owner     = ParseDatabase.sharedDatabase.getCurrentUser()
        
        ParseDatabase.sharedDatabase.createPost(type: PostContentType.Announcement, owner: owner, text: nameCommunity.text, status: PostReport.PostReportStatus.Open, community: community) { (post, error) -> () in
            if let post = post {
                println("Funcionou")
            }else{
                println(error)
            }
        }
        
        /*let post      = ParseDatabase.sharedDatabase.testPost(owner, community: community)
        
        ParseDatabase.sharedDatabase.createComment(owner: owner, text: nameCommunity.text, post: post) { (comment, error) -> () in
            if let comment = comment {
                println("Funcionou")
            }else{
                println(error)
            }
        }*/
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
