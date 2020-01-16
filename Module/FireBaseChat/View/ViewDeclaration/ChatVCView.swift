//
//  ChatVCView.swift
//  FireBaseChat
//
//  Created by Abservetech on 09/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import UIKit

class ChatVCView: UIView {

    
    @IBOutlet weak var msgListTable : UITableView!
    @IBOutlet weak var backImage : UIImageView!
    @IBOutlet weak var pageTitle : UILabel!
    @IBOutlet weak var chatIcon : UIImageView!
    @IBOutlet weak var headerView : UIView!
    @IBOutlet weak var msgView : UIView!
    @IBOutlet weak var emojiImg : UIImageView!
    @IBOutlet weak var sendMsgImg : UIImageView!
    @IBOutlet weak var chatView : SZView!
    @IBOutlet weak var msgTXT : UITextField!
    @IBOutlet weak var bottomCns: NSLayoutConstraint!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupView(){
//         self.chatView.roundedCornerBorder(width: 1, UIColor.lightGray)
      //  self.chatView.isElevation = true
    }
}
