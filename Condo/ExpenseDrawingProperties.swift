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
    
    let borderWidth: CGFloat
    let cornerRadius: CGFloat
    
//    let selectedShapeColor: UIColor
//    let normalShapeColor: UIColor
//    var shapeColor: UIColor {
//        if self.selected {
//            return self.selectedShapeColor
//        }else{
//            return self.normalShapeColor
//        }
//    }
    
    
    let selectedStrokeColor: UIColor
    let normalStrokeColor: UIColor
    var strokeColor: UIColor {
        get{
            if self.selected {
                return self.selectedStrokeColor
            }else{
                return self.normalStrokeColor
            }
        }
    }
    
    let selectedFillColor: UIColor
    let normalFillColor: UIColor
    var fillColor: UIColor {
        get {
            if self.selected {
                return self.selectedFillColor
            }else{
                return self.normalFillColor
            }
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
    
    let normalBorderColor: UIColor
    let selectedBorderColor: UIColor
    var borderColor: UIColor {
        get {
            if self.selected {
                return self.selectedBorderColor
            }else{
                return self.normalBorderColor
            }
        }
    }
    
    init(type: ExpenseType) {
        self.type = type
        self.cornerRadius = 15.0
        self.borderWidth = 2.0
        
        self.selectedStrokeColor = UIColor.whiteColor()
        self.normalStrokeColor = UIColor.whiteColor()
        
        self.selectedFillColor = UIColor.whiteColor()
        self.normalFillColor = UIColor(white: 1.0, alpha: 0.3)
    
        //daqui pra cima é constante e daqui pra baixo é por tipo de despesa
        
        
        switch type {
        case .Water:
            self.svgFileName = "agua"
            self.name = "Água"
            self.normalBackgroundColor = UIColor.condoBlue()
            self.selectedBackgroundColor = UIColor.condoBlue()
            
        case .Energy:
            self.svgFileName = "energia"
            self.name = "Energia Elétrica"
            self.normalBackgroundColor = UIColor.condoYellow()
            self.selectedBackgroundColor = UIColor.condoYellow()
            
        case .Telephone:
            self.svgFileName = "conta-telefonica"
            self.name = "Telefone"
            self.normalBackgroundColor = UIColor.condoBlue()
            self.selectedBackgroundColor = UIColor.condoBlue()
            
        case .Gas:
            self.svgFileName = "gas"
            self.name = "Gás"
            self.normalBackgroundColor = UIColor.condoPurple()
            self.selectedBackgroundColor = UIColor.condoPurple()
            
        case .Personel:
            self.svgFileName = "pessoal"
            self.name = "Pessoal"
            self.normalBackgroundColor = UIColor.condoRed()
            self.selectedBackgroundColor = UIColor.condoRed()
            
        case .CleaningMaterial:
            self.svgFileName = "material-de-limpeza"
            self.name = "Material de limpeza"
            self.normalBackgroundColor = UIColor.condoGreen()
            self.selectedBackgroundColor = UIColor.condoGreen()
            
        case .CleaningServices:
            self.svgFileName = "servico-de-limpeza"
            self.name = "Serviço de limpeza"
            self.normalBackgroundColor = UIColor.condoBlue()
            self.selectedBackgroundColor = UIColor.condoBlue()
            
        case .MaintenanceLift:
            self.svgFileName = "manutencaoelevador"
            self.name = "Manutenção do elevador"
            self.normalBackgroundColor = UIColor.condoRed()
            self.selectedBackgroundColor = UIColor.condoRed()
        
        case .MaintenanceGarden:
            self.svgFileName = "manutencaojardim"
            self.name = "Manutenção do jardim"
            self.normalBackgroundColor = UIColor.condoGreen()
            self.selectedBackgroundColor = UIColor.condoGreen()
            
        case .MaintenanceGenerator:
            self.svgFileName = "manutencaogerador"
            self.name = "Manutenção do gerador"
            self.normalBackgroundColor = UIColor.condoPurple()
            self.selectedBackgroundColor = UIColor.condoPurple()
            
        case .MaintenancePainting:
            self.svgFileName = "pinturaareacomum"
            self.name = "Pintura da área comum"
            self.normalBackgroundColor = UIColor.condoYellow()
            self.selectedBackgroundColor = UIColor.condoYellow()
        
        case .MaintenanceWell:
            self.svgFileName = "manutencaopocoartesiano"
            self.name = "Manutenção do poço artesiano"
            self.normalBackgroundColor = UIColor.condoBlue()
            self.selectedBackgroundColor = UIColor.condoBlue()
            
        default:
            self.name = "TYPE_NOT_IMPLEMENTED"
            self.svgFileName = "test"
            self.normalBackgroundColor = UIColor.grayColor()
            self.selectedBackgroundColor = UIColor.grayColor()
        }
        
        //daqui pra cima é baixo é por tipo de despesa e daqui pra baixo é constante

        
        self.normalBorderColor = self.normalBackgroundColor
        self.selectedBorderColor = self.selectedBackgroundColor
    }
    
    func shouldAnimateSelectionChange(old: Bool, new: Bool) -> Bool{
        if old == new {
            return false
        }
        if old {
            if !new{
                return false
            }
        }
        return true
    }
}
