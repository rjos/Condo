//
//  TesteViewController.swift
//  Condo
//
//  Created by Rodolfo José on 28/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import CondoModel

class TesteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendRequest(sender: AnyObject) {
        
        let user = ParseDatabase.sharedDatabase.getCurrentUser()
        
        let community = ParseDatabase.sharedDatabase.getCommunityUser()
        
        //let postTest = ParseDatabase.sharedDatabase.getPostTest(user, community: community)
        
        //Chamar função para retornar todos os posts
        ParseDatabase.sharedDatabase.getAllPostsAndAnswers(user: user, community: community) { (posts, answers, error) -> () in
            println(posts)
            println(answers)
        }
        //ParseDatabase.sharedDatabase.getAllPostTest(user, community: community)
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
