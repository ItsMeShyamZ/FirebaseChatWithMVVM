//
//  UXTableView.swift
//  FireBaseChat
//
//  Created by Abservetech on 08/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import UIKit

extension UITableView{
    func register(nip nipname : String , as id : String){
        let nib = UINib(nibName: nipname, bundle: nil)
        self.register(nib, forCellReuseIdentifier: id)
    }
    
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}

