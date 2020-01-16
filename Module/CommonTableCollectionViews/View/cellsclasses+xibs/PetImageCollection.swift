//
//  GenericCollectionCell.swift
//  FireBaseChat
//
//  Created by Abservetech on 15/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation
import UIKit

class PetImageCollection : UICollectionViewCell , ConfigCell{
    
    @IBOutlet weak var petName : UILabel!
  
    func configCell(with item: PetImageCollection.T, indexPath: IndexPath) {
        petName.text = item
    }
    
    typealias T = String
    
}
