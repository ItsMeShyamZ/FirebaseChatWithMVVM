//
//  ChatModel.swift
//  FireBaseChat
//
//  Created by Abservetech on 10/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation
import SwiftyJSON


struct UserListMode {
    var name : String = ""
    var id : String = ""
    var profileImg : String = ""
    var online : String = ""
//    var msgCount : Int = 0
    var lastMsg : String = ""
    var time : String = ""
    var isRecived : Bool = false
    var isReaded : Bool = false
    var isInChatPage : Bool = false
    var isNewMsgAdded : Bool = false

    init() {
        
    }
    init(json : JSON) {
        self.name = json["name"].string ?? String()
        self.id = json["id"].string ?? String()
        self.profileImg = json["profileImg"].string ?? String()
        self.online = json["online"].string ?? String()
//        self.msgCount = json["msgCount"].int ?? Int()
        self.lastMsg = json["lastMsg"].string ?? String()
        self.time = json["time"].string ?? String()
        self.isRecived = json["isRecived"].bool ?? Bool()
        self.isReaded = json["isReaded"].bool ?? Bool()
        self.isInChatPage = json["isInChatPage"].bool ?? Bool()
        self.isNewMsgAdded = json["isNewMsgAdded"].bool ?? Bool()
    }
}
