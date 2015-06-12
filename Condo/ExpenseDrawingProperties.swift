//
//  ExpenseDrawingProperties.swift
//  Condo
//
//  Created by Lucas Tenório on 12/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//


let CondoBlue = UIColor.rgba(75, g: 181, b: 198, a: 255)
let yellow = UIColor.rgba(234, g: 186, b: 52, a: 255)
let red = UIColor.rgba(186, g: 81, b: 77, a: 255)
let green = UIColor.rgba(129, g: 195, b: 134, a: 255)
let purple = UIColor.rgba(103, g: 78, b: 142, a: 255)

import CondoModel
struct ExpenseDrawingProperties {
    let type: ExpenseType
    let name: String
    let fillColor: UIColor
    let strokeColor: UIColor
    let backgroundColor: UIColor
    let svgFileName: String
    var selected = false
    init(type: ExpenseType) {
        self.type = type
        self.backgroundColor = UIColor.whiteColor()

        
        switch type {
        case .Water:
            self.svgFileName = "agua"
            self.name = "Água"
            self.fillColor = CondoBlue
            self.strokeColor = CondoBlue //UIColor.rgba(75, g: 181, b: 198, a: 255)
        case .Energy:
            self.svgFileName = "energia"
            self.name = "Energia Elétrica"
            self.fillColor = yellow
            self.strokeColor = yellow
        case .Telephone:
            self.svgFileName = "conta-telefonica"
            self.name = "Telefone"
            self.fillColor = CondoBlue
            self.strokeColor = CondoBlue
        case .Gas:
            self.svgFileName = "gas"
            self.name = "Gás"
            self.fillColor = purple
            self.strokeColor = purple
        case .Personel:
            self.svgFileName = "pessoal"
            self.name = "Pessoal"
            self.fillColor = red
            self.strokeColor = red
        case .CleaningMaterial:
            self.svgFileName = "material-de-limpeza"
            self.name = "Material de limpeza"
            self.fillColor = green
            self.strokeColor = green
        case .CleaningServices:
            self.svgFileName = "servico-de-limpeza"
            self.name = "Serviço de limpeza"
            self.fillColor = CondoBlue
            self.strokeColor = CondoBlue
        default:
            self.name = "TYPE_NOT_IMPLEMENTED"
            self.svgFileName = "test"
            self.fillColor = UIColor.grayColor()
            self.strokeColor = UIColor.grayColor()
        }
    }
}
