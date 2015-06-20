//
//  ProfileViewController.swift
//  Condo
//
//  Created by Rodolfo José on 19/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit
import ParseUI
import CondoModel

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgProfile: PFImageView!
    @IBOutlet weak var lblApt: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var aptView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var btnEditar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.user = ParseDatabase.sharedDatabase.getCurrentUser()
        
        self.aptView.layer.cornerRadius = 10
        self.emailView.layer.cornerRadius = 10
        
        self.aptView.layer.borderColor = UIColor.condoBlue60().CGColor
        self.emailView.layer.borderColor = UIColor.condoBlue60().CGColor
        
        self.aptView.layer.borderWidth = 2
        self.emailView.layer.borderWidth = 2
        
        self.lblApt.textColor = UIColor.condoBlue60()
        self.lblEmail.textColor = UIColor.condoBlue60()
        self.lblName.textColor = UIColor.condoBlue60()
        self.lblType.textColor = UIColor.condoBlue60()
        
        self.btnEditar.tintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    var user : User? {
        didSet{
            if let user = user {
                
                if let image = user.image {
                    self.imgProfile.file = image
                    self.imgProfile.loadInBackground()
                }else{
                    self.imgProfile.image = UIImage(named: user.imageName)
                }
                
                self.lblName.text = user.name
                let community = ParseDatabase.sharedDatabase.getCommunityUser()
                var typeResidents : String = ""
                
                if community.administratorID == user.id {
                    typeResidents = "Síndico"
                }else{
                    typeResidents = "Morador"
                }
                
                self.lblType.text = typeResidents
                self.lblEmail.text = user.email
                
                if let apt = user.apt {
                    self.lblApt.text = apt
                }else{
                    self.lblApt.text = "Número não informado"
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.barTintColor = UIColor.condoBlue80()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
