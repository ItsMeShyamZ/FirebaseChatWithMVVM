//
//  PetUserCellTableViewCell.swift
//  FireBaseChat
//
//  Created by Abservetech on 07/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import UIKit

class PetUserCell: UITableViewCell {
    
    @IBOutlet weak var userImage : UIImageView!
    @IBOutlet weak var userNameLbl : UILabel!
    @IBOutlet weak var userMsgLbl : UILabel!
    @IBOutlet weak var msgTimeLbl : UILabel!
    @IBOutlet weak var msgCountLbl : UILabel!
    @IBOutlet weak var msgCountView : UIView!
    @IBOutlet weak var onLineView : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    func setupView(){
        userImage.isCircleview = true
        msgCountView.isCircleView = true
        onLineView.isCircleView = true
        onLineView.backgroundColor = UIColor.green
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupData(useriD : String,_ user : UserViewModel){
        self.userNameLbl.text = user.name
        self.userImage.getImageFromString(self.userImage, imageurl: user.image)
        if user.online == "online"{
            self.onLineView.isHidden = false
        }else{
            self.onLineView.isHidden = true
        }
        self.msgTimeLbl.text = user.time
        self.userMsgLbl.text = user.lastMsg
        
        FireBaseconnection.instanse.getNewMsgCount(myid: useriD, frndid: user.id) { (count) in
            if count == 0{
                 self.msgCountLbl.isHidden = true
            }else{
                self.msgCountLbl.text = count.description
                self.msgCountLbl.isHidden = false
            }
        }
    }

   
}
