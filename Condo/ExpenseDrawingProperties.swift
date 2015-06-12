//
//  ExpenseDrawingProperties.swift
//  Condo
//
//  Created by Lucas Tenório on 12/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//
import CondoModel
struct ExpenseDrawingProperties {
    let type: ExpenseType
    let name: String
    let fillColor: UIColor
    let strokeColor: UIColor
    let backgroundColor: UIColor
    let svgFileName: String
    init(type: ExpenseType) {
        self.type = type
        self.backgroundColor = UIColor.clearColor()
        switch type {
        case .Water:
            self.svgFileName = "agua"
            self.name = "Água"
            self.strokeColor = UIColor.blueColor()
            self.fillColor = UIColor.blueColor()
        case .Energy:
            self.svgFileName = "energia"
            self.name = "Energia Elétrica"
            self.fillColor = UIColor.yellowColor()
            self.strokeColor = UIColor.yellowColor()
        case .Telephone:
            self.svgFileName = "conta-telefonica"
            self.name = "Telefone"
            self.strokeColor = UIColor.blackColor()
            self.fillColor = UIColor.blackColor()
        case .Gas:
            self.svgFileName = "gas"
            self.name = "Gás"
            self.strokeColor = UIColor.blackColor()
            self.fillColor = UIColor.blackColor()
        case .Personel:
            self.svgFileName = "pessoal"
            self.name = "Pessoal"
            self.strokeColor = UIColor.blackColor()
            self.fillColor = UIColor.blackColor()
        case .CleaningMaterial:
            self.svgFileName = "material-de-limpeza"
            self.name = "Material de limpeza"
            self.strokeColor = UIColor.blackColor()
            self.fillColor = UIColor.blackColor()
        case .CleaningServices:
            self.svgFileName = "servico-de-limpeza"
            self.name = "Serviço de limpeza"
            self.strokeColor = UIColor.blackColor()
            self.fillColor = UIColor.blackColor()
        default:
            self.name = "TYPE_NOT_IMPLEMENTED"
            self.svgFileName = "settings49"
            self.strokeColor = UIColor.blackColor()
            self.fillColor = UIColor.blackColor()
        }
    }
}
