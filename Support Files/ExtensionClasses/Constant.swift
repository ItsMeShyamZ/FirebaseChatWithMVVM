//
//  Constant.swift
//  FireBaseChat
//
//  Created by Abservetech on 07/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation

enum StoryBoardName : String {
    case main = "Main"
    
}

enum CellIdentifiers : String{
    case petUserCell = "PetUserCell"
    case FrndChatCell = "FrndChatCell"
    case MyChatCell = "MyChatCell"
}

enum NibName : String {
    case PetCell = "PetLovers"
    case ChatCell = "ChatCell"
    case MyChatCell = "MyChatCell"
}

enum IDName : String {
    case ChatVC = "ChatVC"
    case PetDatingVC = "PetDatingVC"
    case UserVC = "UserVC"
}

enum R{
    enum userDefaultsKey : String{
        case myid = "myid"
    }
}


//enum StoryBoardName{
//    case Main
//    
//    var Name : String {
//        switch self {
//        case .Main :
//            return "Main"
//
//        }
//    }
//
//}
