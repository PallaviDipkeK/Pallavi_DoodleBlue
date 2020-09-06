//
//  CollCollectionVC.swift
//  Pallavi_DoodleBlue
//
//  Created by mobiotics1067 on 06/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import UIKit

class CollCollectionVC: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    var selectedSec: Bool = false{
        didSet{
            collectionView.reloadSections(IndexSet(integer: selectedIndex))
        }
    }
    var dataModel: [DataModel] = [DataModel]()
     var headerData: [HeaderData] = [HeaderData]()
    var selectedIndex : Int = -1
    private let reuseIdentifier = "CollectionCell"
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    let headerViewReuseIdentifier = "CustomHeaderView"
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        getHeaderData()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        manageUI()
    }
    
    private func manageUI() {
        collectionView?.register(UINib(nibName: "CustomHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerViewReuseIdentifier)
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 40)
        
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewReuseIdentifier, for: indexPath) as? CustomHeaderView else{
            return UICollectionReusableView()
        }
        headerView.btnCollExp.tag = indexPath.section
        headerView.collBtnClecked = didSelectSection
        selectedSec == false ?  headerView.btnCollExp.setImage(#imageLiteral(resourceName: "minus"), for: .normal) :  headerView.btnCollExp.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(headerData.count)
        return headerData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedIndex == section && selectedSec{
            return dataModel.count
        }
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvb", for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
             cell.imgView.image = UIImage(named: dataModel[indexPath.row].image ?? "")
        cell.titleLbl.text = dataModel[indexPath.row].title
        cell.contentView.backgroundColor = .brown
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photoPerRow: CGFloat = 3.0
        let paddingSpace = sectionInsets.left * (photoPerRow + 1)
        let availableWidth = UIScreen.main.bounds.width - paddingSpace
        let widthPerItem = availableWidth / photoPerRow
        
        return CGSize(width: widthPerItem , height: widthPerItem)
    }
}
extension CollCollectionVC{
    func didSelectSection(tag: Int){

        for var i in headerData{
            if i.headerId == tag{
                self.selectedIndex = i.headerId ?? -1
              self.selectedSec = !(i.selection ?? false)
                i.updateHeader(selection: (i.selection ?? false))
              
            }
        }
       
       
    }
    func getData(){
        var item = DataModel()
        item = DataModel(cellType: .MultiSelect, image: "image1", title: "Header1")
        dataModel.append(item)
        item = DataModel(cellType: .SingleSelect, image: "image2", title: "Header2")
        dataModel.append(item)
        item = DataModel(cellType: .MultiSelect, image: "image3", title: "Header3")
        dataModel.append(item)
        item = DataModel(cellType: .SingleSelect, image: "image4", title: "Header4")
        dataModel.append(item)
        item = DataModel(cellType: .MultiSelect, image: "image5", title: "Header5")
        dataModel.append(item)
        item = DataModel(cellType: .SingleSelect, image: "image6", title: "Header6")
        dataModel.append(item)
        item = DataModel(cellType: .MultiSelect, image: "image7", title: "Header7")
        dataModel.append(item)
        item = DataModel(cellType: .SingleSelect, image: "image8", title: "Header8")
        dataModel.append(item)
        item = DataModel(cellType: .SingleSelect, image: "image1", title: "Header9")
               dataModel.append(item)
      
    }
    func getHeaderData(){
        var item = HeaderData()
        item = HeaderData(headerId: 0, selection: false)
        headerData.append(item)
         item = HeaderData(headerId: 1, selection: false)
        headerData.append(item)
         item = HeaderData(headerId: 2, selection: false)
        headerData.append(item)
     
               
      
    }
}
