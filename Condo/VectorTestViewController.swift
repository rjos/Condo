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
        self.vectorView.drawSVGWithName("cleaningServices")
        
        //Colocando as propriedades opcionais de desenho
        self.vectorView.fillColor = UIColor.grayColor()      //A cor de preenchimento do SVG
        self.vectorView.strokeColor = UIColor.whiteColor()   //A cor de desenho do SVG
        self.vectorView.lineWidth = 2.0                      //A largura da linha de desenho
        self.vectorView.animationDuration = 2.0              //A duração total da animação
        self.vectorView.animateFadeIn = false                 //Se deve animar a opacidade do SVG junto com o desenho
        self.vectorView.onlyFillAfterAnimation = false        //Se verdadeiro, a cor de preenchimento só aparecerá depois da animação
        self.vectorView.onlyStrokeAfterAnimation = false      //Se verdadeiro, a cor de desenho só aparecerá depois da animação
        
    }
    @IBAction func animateButtonPressed(sender: UIButton) {
        self.vectorView.animateShape()
    }
}
