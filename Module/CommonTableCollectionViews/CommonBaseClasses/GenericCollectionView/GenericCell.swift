//
//  BaseCollectionViewCell.swift
//  FireBaseChat
//
//  Created by Abservetech on 14/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation
import UIKit

//class BaseCollectionViewCell<U> : UICollectionViewCell{
//    var item : U!
//}

protocol ReuseCollectionCell {
    static var reuseIdentifier : String {
        get
    }
    
}


extension ReuseCollectionCell{
    static var reuseIdentifier : String{
        return String(describing : self)
    }
}


protocol ConfigCell : ReuseCollectionCell {
    
    associatedtype T
     
    func configCell(with item : T , indexPath : IndexPath)
    
}
