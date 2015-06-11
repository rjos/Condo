//
//  VectorTestViewController.swift
//  Condo
//
//  Created by Lucas Tenório on 11/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit

class VectorTestViewController: UIViewController {

    @IBOutlet weak var vectorView: VectorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vectorView.drawSVGWithName("settings49")
        self.vectorView.fillColor = UIColor.clearColor()
        self.vectorView.strokeColor = UIColor.whiteColor()
        self.vectorView.lineWidth = 2.0
        self.vectorView.animationDuration = 2.0
    }
    @IBAction func animateButtonPressed(sender: UIButton) {
        self.vectorView.animateShape()
    }
}
