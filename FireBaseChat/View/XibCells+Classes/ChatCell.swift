//
//  ChatCell.swift
//  FireBaseChat
//
//  Created by Abservetech on 10/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import UIKit

class FrndChatCell: UITableViewCell {
    
    @IBOutlet weak var frndMsgView : UIView!
    @IBOutlet weak var frndMsgLbl : UILabel!
    @IBOutlet weak var frndMsgbgLbl : UILabel!
    @IBOutlet weak var frndMsgTimeLbl : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        frndMsgLbl.roundCorners([.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMaxXMaxYCorner], radius: 20)
        frndMsgbgLbl.roundCorners([.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMaxXMaxYCorner], radius: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setupData(_ user : MsgViewModel){
        self.frndMsgLbl.text = user.msg
        self.frndMsgTimeLbl.text = user.time
    }
}


class MyChatCell: UITableViewCell {
    
    @IBOutlet weak var myMsgView : UIView!
    @IBOutlet weak var myMsgLbl : UILabel!
    @IBOutlet weak var myMsgbgLbl : UILabel!
    @IBOutlet weak var myMsgTimeLbl : UILabel!
    @IBOutlet weak var msgViewTick : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        myMsgbgLbl.roundCorners([.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMinXMaxYCorner], radius: 20)
        myMsgLbl.roundCorners([.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMinXMaxYCorner], radius: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setupData(isViewed : Bool, _ user : MsgViewModel){
        self.myMsgLbl.text = user.msg
         self.myMsgTimeLbl.text = user.time
        if isViewed{
            self.msgViewTick.image = UIImage(named: "viewed")
            self.msgViewTick.tintColor = UIColor(named: "AppColor")
        }else{
            self.msgViewTick.image = UIImage(named: "send")
            self.msgViewTick.tintColor = UIColor.lightGray
        }
    }
}
