//
//  FireBaseConnection.swift
//  FireBaseChat
//
//  Created by Abservetech on 11/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import SwiftyJSON


class FireBaseconnection{
    
    static let instanse = FireBaseconnection()
    let fireBaseref : DatabaseReference = Database.database().reference()
    
    var firebaseUserList : [UserListMode] = [UserListMode]()
    var msgList : [MsgListModel] = [MsgListModel]()
    let storageRef = Storage.storage().reference()
    
    var useriD : String = UserDefaults.standard.value(forKey: R.userDefaultsKey.myid.rawValue) as? String ?? ""
    
    func uploadeImage(userImage : UIImage,userid : String , name : String ,added : @escaping(String)->()){
    
        let riversRef = storageRef.child("imyImage\(userid).jpg")
        if let data = userImage.pngData() {
            let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error",error)
                    
                } else {
                    guard let metadata = metadata else {
                        return
                    }
                    let size = metadata.size
                    riversRef.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                            return
                        }
                        log.info("downloadURL \(downloadURL)")
                        self.addUserDetail(userid: userid, name: name,profileImg: downloadURL) { (done) in
                            added("done")
                        }
                    }
                }
                
            }
        }
    }
    
    func addUserDetail(userid : String , name : String,profileImg : URL ,added : @escaping(String)->()){
           let userArray = [
               "name": name ,
               "id" : userid,
               "profileImg" : profileImg.absoluteString
            
            ] as [String : Any]
           fireBaseref.child("userData").child(userid).updateChildValues(userArray)
            added("done")
       }
    
    func getUserCount(count : @escaping(Int)->()){
        fireBaseref.child("userData").observe(.value) { (snapShot) in
            count(Int(snapShot.children.allObjects.count.description) ?? 0)
        }
    }
    
    func getuserList(userLists : @escaping ([UserListMode]) -> ()){
        fireBaseref.child("userData").observe(.value) { (snapShot) in
            self.firebaseUserList.removeAll()
            for result in snapShot.children.allObjects as! [DataSnapshot]{
                let jsonData = JSON(result.value)
                if UserListMode.init(json: jsonData).id != self.useriD{
                    self.firebaseUserList.append(UserListMode.init(json: jsonData))
                }
                userLists(self.firebaseUserList)
            }
            
        }
    }
    
    func getUserData(userid : String,userdata : @escaping (UserListMode) -> ()){
        fireBaseref.child("userData").child(userid).observe(.value) { (snapShot) in
                       let jsonData = JSON(snapShot.value)
                       
                       userdata(UserListMode(json: jsonData))
                   
                   
               }
    }
    
    func updateOnline(online : String){
        let userid : String = UserDefaults.standard.value(forKey: R.userDefaultsKey.myid.rawValue) as? String ?? ""
        if !userid.isEmpty{
        let userArray = [
             "online": online,
             "isRecived" : true
        ] as [String : Any]
        fireBaseref.child("userData").child(userid).updateChildValues(userArray)
        }
    }
    
    func isInChatPage(ischat : Bool){
         let userid : String = UserDefaults.standard.value(forKey: R.userDefaultsKey.myid.rawValue) as? String ?? ""
         if !userid.isEmpty{
         let userArray = [
              "isInChatPage": ischat
         ] as [String : Any]
         fireBaseref.child("userData").child(userid).updateChildValues(userArray)
         }
     }
    
    func getNewMsgCount(myid : String , frndid : String, NewMsgCount : @escaping (Int) -> ()) {
        if !myid.isEmpty  && !frndid.isEmpty{
    fireBaseref.child("MsgCount").child("\(frndid)-\(myid)").child(myid).observe(.value) { (snapShot) in
            let jsonData = JSON(snapShot.value)
            NewMsgCount(Int(jsonData["msgcount"].int ?? 0))
        
        }
        }
    }
    
    func updateMsgcount(myid : String , frndid : String, frndMsgCount : @escaping (Int) -> ()) {
        if !myid.isEmpty  && !frndid.isEmpty{
            let msgCount = [
                       "msgcount" : 0
                   ]
        fireBaseref.child("MsgCount").child("\(frndid)-\(myid)").child(myid).updateChildValues(msgCount)
        
        let userid : String = UserDefaults.standard.value(forKey: R.userDefaultsKey.myid.rawValue) as? String ?? ""
               if !userid.isEmpty{
               let userArray = [
                   "isRecived" : true,
                   "isReaded" : true
               ] as [String : Any]
               fireBaseref.child("userData").child(myid).updateChildValues(userArray)
               }
        
        
        fireBaseref.child("MsgCount").child("\(myid)-\(frndid)").child(frndid).observe(.value) { (snapShot) in
                let jsonData = JSON(snapShot.value)
                frndMsgCount(Int(jsonData["msgcount"].int ?? 0))
            
            }
        }
    }
    
    func sendMsg(msg : String , time : String , myid : String , frndid : String,msgCount : Int , complitionHandler : @escaping ()->()){
        if !myid.isEmpty  && !frndid.isEmpty{
        let msgArray = [
            "msg": msg,
            "time": time,
            "id" : myid
            ] as [String : Any]
        fireBaseref.child("Chat").child("\(myid)-\(frndid)").childByAutoId().updateChildValues(msgArray)
        fireBaseref.child("Chat").child("\(frndid)-\(myid)").childByAutoId().updateChildValues(msgArray)
        
            let msgCount = [
                "msgcount" : msgCount
            ]
        fireBaseref.child("MsgCount").child("\(myid)-\(frndid)").child(frndid).updateChildValues(msgCount)
       
        
        
        let msgDetail = [
                   "lastMsg": msg,
                   "time": time,
                   "isRecived" : false,
                   "isNewMsgAdded" : true,
                   "isReaded" : false,
                   ] as [String : Any]
        
        fireBaseref.child("userData").child(frndid).updateChildValues(msgDetail)
        
        let myMsgDetail = [
            "msgCount": 0,
            "lastMsg": msg,
            "time": time,
            "isRecived" : true,
            "isReaded" : true
            ] as [String : Any]
        
        fireBaseref.child("userData").child(myid).updateChildValues(myMsgDetail)
        
        complitionHandler()
        }
   }
    
    
    func getMsgList(myid : String , frndid : String,userLists : @escaping ([MsgListModel]) -> ()){
        if !myid.isEmpty  && !frndid.isEmpty{
        fireBaseref.child("Chat").child("\(myid)-\(frndid)").observe(.value) { (snapShot) in
            self.msgList.removeAll()
            for result in snapShot.children.allObjects as! [DataSnapshot]{
                let jsonData = JSON(result.value)
                self.msgList.append(MsgListModel.init(json: jsonData))
                userLists(self.msgList)
            }
            
        }
        }
    }
}
