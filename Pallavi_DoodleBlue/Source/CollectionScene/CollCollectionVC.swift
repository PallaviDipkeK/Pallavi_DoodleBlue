    //
    //  CollCollectionVC.swift
    //  Pallavi_DoodleBlue
    //
    //  Created by mobiotics1067 on 06/09/20.
    //  Copyright © 2020 mobiotics1067. All rights reserved.
    //
    
    import UIKit
    
    class CollCollectionVC: UICollectionViewController,UICollectionViewDelegateFlowLayout {

        @IBOutlet weak var singleSelectBtn: UIBarButtonItem!
        fileprivate var headerData: [HeaderData] = [HeaderData]()
        var selectedAction : CellType = .SingleSelect
        var selectedSegment : Int = -1
        private let reuseIdentifier = "CollectionCell"
        let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        private let headerViewReuseIdentifier = "CustomHeaderView"
        override func viewDidLoad() {
            super.viewDidLoad()
            manageUI()
            self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            
        }
        
        @IBAction func singleSelectActn(_ sender: Any) {
            if selectedAction == .SingleSelect {
                singleSelectBtn.title = "Multiple"
                selectedAction = .MultiSelect
            }else{
                singleSelectBtn.title = "Single"
                selectedAction = .SingleSelect
            }
            collectionView.reloadData()
        }
        private func manageUI() {
            let setData = SetData()
            headerData = setData.getHeaderData()
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
            selectedSegment == indexPath.section ?  headerView.btnCollExp.setImage(#imageLiteral(resourceName: "minus"), for: .normal) :  headerView.btnCollExp.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
            return headerView
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsets
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return sectionInsets.left
        }
        
        override func numberOfSections(in collectionView: UICollectionView) -> Int {
            return headerData.count
        }
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print(section)
            if selectedSegment == section{
                return 0
            }
            return headerData[section].dataModel?.count ?? 0
            
        }
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvb", for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
            if selectedSegment != indexPath.section{
                if let dataAtIndex = headerData[indexPath.section].dataModel?[indexPath.row]{
                    let image = UIImage(named:dataAtIndex.image ?? "")
                    cell.imgView.image =  image
                    cell.titleLbl.text = dataAtIndex.title
                    if selectedAction == .SingleSelect {
                        dataAtIndex.isselectedIndex == true  ? cell.selectionBtn.setImage(#imageLiteral(resourceName: "singleSl2"), for: .normal) :  cell.selectionBtn.setImage(#imageLiteral(resourceName: "singleSel1"), for: .normal)
                    }else{
                        dataAtIndex.isselectedIndex == true ?  cell.selectionBtn.setImage(#imageLiteral(resourceName: "multiSel2"), for: .normal) :  cell.selectionBtn.setImage(#imageLiteral(resourceName: "multiSel1"), for: .normal)
                    }
                }
            }
            return cell
        }
        
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            if headerData[indexPath.section].dataModel != nil{
               self.selectedSegment = indexPath.section
                if selectedAction == .SingleSelect {
                    //if indexPath.section == selectedSegment{
                    self.updateSingleSelection(selectedItem: indexPath.row,data: headerData[indexPath.section], selectedSection: indexPath.section)
                    //  }
                 }else{
                    self.updateMultipeSelection(selectedItem: indexPath.row,data: headerData[indexPath.section], selectedSection: indexPath.section)
                }
                 collectionView.reloadData()
            }
           
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let photoPerRow: CGFloat = 3.0
            let paddingSpace = sectionInsets.left * (photoPerRow + 1)
            let availableWidth = collectionView.frame.width - paddingSpace
            let widthPerItem = availableWidth / photoPerRow
            
            return CGSize(width: widthPerItem , height: widthPerItem)
        }
    }
    extension CollCollectionVC{
        func didSelectSection(tag: Int){
            for var i in headerData{
                if i.headerId == tag{
                  //  self.selectedSegment = !(i.selection ?? false)
                    i.updateHeader(selection: (i.selection ?? false), data: i.dataModel)
                }
            }
        }
        func updateSingleSelection(selectedItem: Int,data: HeaderData,selectedSection: Int){
            for (index,indexData) in ((data.dataModel)?.enumerated())!{
                var itemAtIndex = DataModel()
                if index == selectedItem{
                    itemAtIndex.updateCellData(selection: indexData.isselectedIndex, image: indexData.image, title: indexData.title, section: indexData.section)
                    headerData[selectedSection].dataModel?[index] = itemAtIndex
                }else{
                    itemAtIndex.updateCellData(selection: true, image: indexData.image, title: indexData.title, section: indexData.section)
                    headerData[selectedSection].dataModel?[index] = itemAtIndex
                }
            }
        }
        func updateMultipeSelection(selectedItem: Int,data: HeaderData,selectedSection: Int){
            for (index,indexData) in ((data.dataModel)?.enumerated())!{
                var itemAtIndex = DataModel()
                if index == selectedItem{
                    itemAtIndex.updateCellData(selection: indexData.isselectedIndex, image: indexData.image, title: indexData.title, section: indexData.section)
                    headerData[selectedSection].dataModel?[index] = itemAtIndex
                    
                }
            }
        }
    }
    
