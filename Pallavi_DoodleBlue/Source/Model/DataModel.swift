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
   var image: String?
    var title: String?
    var isselectedIndex: Bool?
    var section: Int?
    mutating func updateCellData(selection: Bool?,image: String?,title: String?,section: Int?) {
         self.isselectedIndex = !(selection ?? false)
        self.title = title ?? ""
        self.image =  image ?? ""
        self.section = section ?? 0
        
    }
}

struct HeaderData {
    var headerId: Int?
    var selection: Bool?
    var dataModel: [DataModel]?

    mutating func updateHeader(selection: Bool?,data: [DataModel]?) {
       self.selection = !(selection ?? false)
        self.dataModel = data
    }
}

class SetData{
      var headerData: [HeaderData] = [HeaderData]()
    func getData(section: Int) -> [DataModel]{
        var dataModel: [DataModel] = [DataModel]()
        var item = DataModel()
        item = DataModel(image: "image1", title: "Header1", isselectedIndex: false,section: section)
        dataModel.append(item)
        item = DataModel(image: "image1", title: "Header2", isselectedIndex: false,section: section)
        dataModel.append(item)
        item = DataModel(image: "image1", title: "Header3", isselectedIndex: false,section: section)
        dataModel.append(item)
        item = DataModel(image: "image1", title: "Header4", isselectedIndex: false,section: section)
        dataModel.append(item)
        item = DataModel(image: "image1", title: "Header5", isselectedIndex: false,section: section)
        dataModel.append(item)
        item = DataModel(image: "image1", title: "Header6", isselectedIndex: false,section: section)
        dataModel.append(item)
        return dataModel
    }
    
    func getHeaderData() -> [HeaderData]{
        headerData = [ HeaderData(headerId: 0, selection: false,dataModel: getData(section: 0)),  HeaderData(headerId: 0, selection: false,dataModel: getData(section: 1))]
        return headerData
    }
}
