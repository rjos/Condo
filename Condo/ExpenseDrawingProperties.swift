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
    let svgFileName: String
    var selected = false
    
    let selectedShapeColor: UIColor
    let normalShapeColor: UIColor
    var shapeColor: UIColor {
        if self.selected {
            return self.selectedShapeColor
        }else{
            return self.normalShapeColor
        }
    }
    
    let normalBackgroundColor: UIColor
    let selectedBackgroundColor: UIColor
    var backgroundColor: UIColor {
        if self.selected {
            return self.selectedBackgroundColor
        }else{
            return self.normalBackgroundColor
        }
    }
    
    init(type: ExpenseType) {
        self.type = type
        
        self.normalBackgroundColor = UIColor.whiteColor()
        self.selectedShapeColor = UIColor.whiteColor()
        
        switch type {
            
        case .Water:
            self.svgFileName = "agua"
            self.name = "Água"
            self.normalShapeColor = UIColor.condoBlue()
            self.selectedBackgroundColor = UIColor.condoBlue()
            
        case .Energy:
            self.svgFileName = "energia"
            self.name = "Energia Elétrica"
            self.normalShapeColor = UIColor.condoYellow()
            self.selectedBackgroundColor = UIColor.condoYellow()
            
        case .Telephone:
            self.svgFileName = "conta-telefonica"
            self.name = "Telefone"
            self.normalShapeColor = UIColor.condoBlue()
            self.selectedBackgroundColor = UIColor.condoBlue()
            
        case .Gas:
            self.svgFileName = "gas"
            self.name = "Gás"
            self.normalShapeColor = UIColor.condoPurple()
            self.selectedBackgroundColor = UIColor.condoPurple()
            
        case .Personel:
            self.svgFileName = "pessoal"
            self.name = "Pessoal"
            self.normalShapeColor = UIColor.condoRed()
            self.selectedBackgroundColor = UIColor.condoRed()
            
        case .CleaningMaterial:
            self.svgFileName = "material-de-limpeza"
            self.name = "Material de limpeza"
            self.normalShapeColor = UIColor.condoGreen()
            self.selectedBackgroundColor = UIColor.condoGreen()
            
        case .CleaningServices:
            self.svgFileName = "servico-de-limpeza"
            self.name = "Serviço de limpeza"
            self.normalShapeColor = UIColor.condoBlue()
            self.selectedBackgroundColor = UIColor.condoBlue()
            
        default:
            self.name = "TYPE_NOT_IMPLEMENTED"
            self.svgFileName = "test"
            self.normalShapeColor = UIColor.grayColor()
            self.selectedBackgroundColor = UIColor.grayColor()
        }
    }
}
