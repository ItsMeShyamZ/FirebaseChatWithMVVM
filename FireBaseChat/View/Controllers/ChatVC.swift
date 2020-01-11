//
//  ChatVC.swift
//  FireBaseChat
//
//  Created by Abservetech on 09/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    // MARK: - <# VC initializer #>
    
    class func initWithStoryBoard() -> ChatVC{
        let vc = UIStoryboard(name: StoryBoardName.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: IDName.ChatVC.rawValue) as! ChatVC
        return vc
    }
    
    var msgCount  : Int = 0
    
    public var chatUIView : ChatVCView!{
        guard  isViewLoaded else {return nil}
        return (view as! ChatVCView)
    }
    
    var FBConnet  = FireBaseconnection.instanse
    var userDetail : UserListMode?
    var msgVM : MsgListViewModel?
    var useriD : String = ""
    var msgList  : [MsgListModel] = [MsgListModel](){
        didSet{
            self.msgVM = MsgListViewModel(msgList)
            chatUIView.msgListTable.reloadData()
            UIView.setAnimationsEnabled(false)
            chatUIView.msgListTable.scrollToBottom()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.FBConnet.getMsgList(myid: useriD ?? "", frndid: self.userDetail?.id ?? "") { (msgList) in
            log.info("msgList \(msgList)")
            self.msgList = msgList
        }
        self.FBConnet.isInChatPage(ischat: true)
        self.FBConnet.updateMsgcount(myid: useriD ?? "", frndid: self.userDetail?.id ?? "", frndMsgCount: { msgCount in
            self.msgCount = msgCount
            self.FBConnet.getMsgList(myid: self.useriD ?? "", frndid: self.userDetail?.id ?? "") { (msgList) in
                log.info("msgList \(msgList)")
                self.msgList = msgList
            }
        })
        self.FBConnet.getUserData(userid: self.userDetail?.id ?? "") { (userData) in
            self.userDetail = userData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.useriD = UserDefaults.standard.value(forKey: R.userDefaultsKey.myid.rawValue) as? String ?? ""
        
        chatUIView.setupView()
        self.setupDelegate()
        self.setupAction()
        
        chatUIView.msgTXT.delegate = self
        chatUIView.pageTitle.text = userDetail?.name ?? ""
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupAction(){
        self.chatUIView.backImage.addAction(for: .tap) {
            self.dismiss(animated: true, completion: nil)
        }
        
        self.chatUIView.sendMsgImg.addAction(for: .tap) {
            self.view.endEditing(true)
            if (self.chatUIView.msgTXT.text ?? "").isEmpty {
                self.chatUIView.chatView.isError = true
            }else{
                let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
                if self.userDetail?.isInChatPage ?? false{
                    self.msgCount = 0
                }else{
                    self.msgCount = self.msgCount + 1
                }
                self.FBConnet.sendMsg(msg: self.chatUIView.msgTXT.text ?? "", time: timestamp, myid: self.useriD ?? "", frndid: self.userDetail?.id ?? "", msgCount: self.msgCount,complitionHandler: {
                    self.chatUIView.msgTXT.text = ""
                })
            }
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        if let info = notification.userInfo{
            let rect : CGRect = info["UIKeyboardFrameEndUserInfoKey"] as? CGRect ?? CGRect()
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.01) {
                self.view.layoutIfNeeded()
                self.chatUIView.bottomCns.constant = rect.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        if let info = notification.userInfo{
            
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.10) {
                self.view.layoutIfNeeded()
                self.chatUIView.bottomCns.constant = 0
            }
        }
    }
    
}

// MARK: - <# Chat Table  #>

extension ChatVC : UITableViewDelegate , UITableViewDataSource{
    
    func setupDelegate(){
        chatUIView.msgListTable.register(nip: NibName.ChatCell.rawValue, as: CellIdentifiers.FrndChatCell.rawValue)
        chatUIView.msgListTable.register(nip: NibName.MyChatCell.rawValue, as: CellIdentifiers.MyChatCell.rawValue)
        
        chatUIView.msgListTable.delegate = self
        chatUIView.msgListTable.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgVM?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.msgList[indexPath.row].id ==  useriD{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MyChatCell.rawValue, for: indexPath) as! MyChatCell
            if (self.msgList.count - (indexPath.row)) <= self.msgCount{
                cell.setupData(isViewed: false, msgVM!.msgAtIndex(indexPath.row))
            }else{
                cell.setupData(isViewed: true, msgVM!.msgAtIndex(indexPath.row))
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.FrndChatCell.rawValue, for: indexPath) as! FrndChatCell
            cell.setupData(msgVM!.msgAtIndex(indexPath.row))
            return cell
        }
        
        
    }
    
}

extension ChatVC : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
