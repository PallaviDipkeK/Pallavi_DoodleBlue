//
//  DataModel.swift
//  Pallavi_DoodleBlue
//
//  Created by mobiotics1067 on 06/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import Foundation
enum CellType{
    case SingleSelect
    case MultiSelect
}
struct DataModel {
    var cellType: CellType?
    var image: String?
    var title: String?
    
}

struct HeaderData {
    var headerId: Int?
    var selection: Bool?


    mutating func updateHeader(selection: Bool?) {
       self.selection = !(selection ?? false)
        print( self.selection)
        
    }
}
