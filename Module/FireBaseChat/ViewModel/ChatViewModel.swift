//
//  ChatViewModel.swift
//  FireBaseChat
//
//  Created by Abservetech on 10/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation


struct ChatListViewModel {
     var userList : [UserListMode]
    
    
    init(_ userlist : [UserListMode]) {
          self.userList = userlist
      }
}


extension ChatListViewModel{
    var numberOfSection : Int {
        return 1
    }

    func numberOfRowsInSection(_ section : Int) -> Int{
        return userList.count
    }

    func userAtIndex(_ index : Int) -> UserViewModel{
        let msg = userList[index]
        return UserViewModel(msg)
    }
}


struct UserViewModel {
    private var user : UserListMode
   
}


extension UserViewModel {
    
    init(_ userview : UserListMode) {
        self.user = userview
    }
}


extension UserViewModel{
    var name : String{
        return self.user.name
    }
    
    var image : String{
           return self.user.profileImg
       }
    
    var id : String{
              return self.user.id
          }
    
    var online : String {
        return self.user.online
    }
    
    var lastMsg : String {
        return self.user.lastMsg
    }
    
    var time : String {
        return self.user.time
    }
    
    var isRecived : Bool {
        return self.user.isRecived
    }
}



