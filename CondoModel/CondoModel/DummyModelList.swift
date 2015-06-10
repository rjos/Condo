//
//  DummyModelList.swift
//  CondoModel
//
//  Created by Lucas Tenório on 09/06/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//

import UIKit

class DummyModelList: NSObject, ModelList {
    let data: Array<Model>
    init(data: Array<Model>) {
        self.data = data
    }
    
    func count() -> Int {
        return data.count
    }
    
    func modelAtIndex(index: Int) -> Model {
        return self.data[index]
    }
    
    func hasMoreData() -> Bool {
        return false
    }
}
