//
//  MsgModel.swift
//  FireBaseChat
//
//  Created by Abservetech on 11/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MsgListModel {
    var msg : String = ""
    var time : String = ""
    var id : String = ""

    init() {
        
    }
    init(json : JSON) {
        self.msg = json["msg"].string ?? String()
        self.time = json["time"].string ?? String()
        self.id = json["id"].string ?? String()
    }
}
