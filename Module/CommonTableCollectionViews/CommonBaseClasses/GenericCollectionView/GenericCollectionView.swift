//
//  BaseCollectionView.swift
//  FireBaseChat
//
//  Created by Abservetech on 14/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation
import UIKit

class GenericCollectionView : NSObject, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
   
    
}
