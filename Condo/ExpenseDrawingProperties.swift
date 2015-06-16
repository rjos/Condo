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
            self.svgFileName = "water"
            self.name = "Água"
            self.normalBackgroundColor = UIColor.condoBlue()
            self.selectedBackgroundColor = UIColor.condoBlue()
            
        case .Energy:
            self.svgFileName = "energy"
            self.name = "Energia Elétrica"
            self.normalBackgroundColor = UIColor.condoYellow()
            self.selectedBackgroundColor = UIColor.condoYellow()
            
        case .Telephone:
            self.svgFileName = "telephone"
            self.name = "Telefone"
            self.normalBackgroundColor = UIColor.condoBlue()
            self.selectedBackgroundColor = UIColor.condoBlue()
            
        case .Gas:
            self.svgFileName = "gas"
            self.name = "Gás"
            self.normalBackgroundColor = UIColor.condoPurple()
            self.selectedBackgroundColor = UIColor.condoPurple()
            
        case .Personel:
            self.svgFileName = "personel"
            self.name = "Pessoal"
            self.normalBackgroundColor = UIColor.condoRed()
            self.selectedBackgroundColor = UIColor.condoRed()
            
        case .CleaningMaterial:
            self.svgFileName = "cleaningMaterial"
            self.name = "Material de Limpeza"
            self.normalBackgroundColor = UIColor.condoGreen()
            self.selectedBackgroundColor = UIColor.condoGreen()
            
        case .CleaningServices:
            self.svgFileName = "cleaningServices"
            self.name = "Serviço de Limpeza"
            self.normalBackgroundColor = UIColor.condoBlue()
            self.selectedBackgroundColor = UIColor.condoBlue()
            
        case .MaintenanceLift:
            self.svgFileName = "maintenanceLift"
            self.name = "Manutenção do Elevador"
            self.normalBackgroundColor = UIColor.condoRed()
            self.selectedBackgroundColor = UIColor.condoRed()
        
        case .MaintenanceGarden:
            self.svgFileName = "maintenanceGarden"
            self.name = "Manutenção do Jardim"
            self.normalBackgroundColor = UIColor.condoGreen()
            self.selectedBackgroundColor = UIColor.condoGreen()
            
        case .MaintenanceGenerator:
            self.svgFileName = "maintenanceGenerator"
            self.name = "Manutenção do Gerador"
            self.normalBackgroundColor = UIColor.condoPurple()
            self.selectedBackgroundColor = UIColor.condoPurple()
            
        case .MaintenancePainting:
            self.svgFileName = "maintenancePainting"
            self.name = "Pintura da Área Comum"
            self.normalBackgroundColor = UIColor.condoYellow()
            self.selectedBackgroundColor = UIColor.condoYellow()
        
        case .MaintenanceWell:
            self.svgFileName = "maintenanceWell"
            self.name = "Manutenção do Poço Artesiano"
            self.normalBackgroundColor = UIColor.condoBlue()
            self.selectedBackgroundColor = UIColor.condoBlue()
            
        case .OtherExpense:
            self.svgFileName = "otherExpense"
            self.name = "Outra Despesa" //AQUI FICARÁ O NOME DA DESPESA CUSTOM CRIADA PELO SÍNDICO
            self.normalBackgroundColor = UIColor.condoBlue()
            self.selectedBackgroundColor = UIColor.condoBlue()
        case .Insurance:
            self.svgFileName = "insurance"
            self.name = "Seguro do Condomínio"
            self.normalBackgroundColor = UIColor.condoRed()
            self.selectedBackgroundColor = UIColor.condoRed()
        case .AdministrationCost:
            self.svgFileName = "administrationCost"
            self.name = "Custo de Administração"
            self.normalBackgroundColor = UIColor.condoGreen()
            self.selectedBackgroundColor = UIColor.condoGreen()
        case .MaintenancePestControl:
            self.svgFileName = "maintenancePestControl"
            self.name = "Dedetização"
            self.normalBackgroundColor = UIColor.condoGreen()
            self.selectedBackgroundColor = UIColor.condoGreen()
        }
        
//        default:
//            self.svgFileName = "otherExpense"
//            self.name = "Despesa Desconhecida"
//            self.normalBackgroundColor = UIColor.grayColor()
//            self.selectedBackgroundColor = UIColor.grayColor()
//        }
        
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
