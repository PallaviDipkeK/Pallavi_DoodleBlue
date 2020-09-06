//
//  CustomHeaderView.swift
//  FlickrTest
//
//  Created by Prashant Gautam on 11/06/18.
//  Copyright © 2018 gautam1001. All rights reserved.


import Foundation
import UIKit

class CustomHeaderView : UICollectionReusableView {
   
    @IBOutlet weak var refreshControlIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnCollExp: UIButton!
    var collBtnClecked:((Int) -> (Void))?
    var isExpanded:Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
       self.backgroundColor = .gray
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    @IBAction func didSelectCollExpBtn(_ sender: UIButton) {
      self.collBtnClecked?(sender.tag)
    }
}
