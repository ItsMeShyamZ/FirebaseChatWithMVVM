//
//  MsgViewModel.swift
//  FireBaseChat
//
//  Created by Abservetech on 11/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation

struct MsgListViewModel {
     var msgList : [MsgListModel]
    
    
    init(_ msgList : [MsgListModel]) {
          self.msgList = msgList
      }
}


extension MsgListViewModel{
    var numberOfSection : Int {
        return 1
    }

    func numberOfRowsInSection(_ section : Int) -> Int{
        return msgList.count
    }

    func msgAtIndex(_ index : Int) -> MsgViewModel{
        let msg = msgList[index]
        return MsgViewModel(msg)
    }
}


struct MsgViewModel {
     var msgData : MsgListModel
   
}


extension MsgViewModel {
    
    init(_ msgData : MsgListModel) {
        self.msgData = msgData
    }
}


extension MsgViewModel{
    var msg : String{
        return self.msgData.msg
    }
    
    var time : String{
           return self.msgData.time
       }
    
    var id : String{
        return self.msgData.id
    }
 
}



