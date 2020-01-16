//
//  PetDatingVCViewController.swift
//  FireBaseChat
//
//  Created by Abservetech on 07/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import UIKit

class PetDatingVC: UIViewController {
    
    // MARK: - <# VC initializer #>
    
    class func initWithStoryBoard() -> PetDatingVC{
        let vc = UIStoryboard(name: StoryBoardName.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: IDName.PetDatingVC.rawValue) as! PetDatingVC
        return vc
    }
    
    // MARK: - <#  Veriable Declaraction #>
    
    public var petUserView : petDatingView! {
        guard  isViewLoaded else {return nil}
        return (view as! petDatingView)
    }
    
    var FBConnet  = FireBaseconnection.instanse
    
    var userList  : [UserListMode] = [UserListMode](){
        didSet{
            self.chatVM = ChatListViewModel(userList)
            petUserView.petUserTable.reloadData()
        }
    }
    
    var chatVM : ChatListViewModel?
    var useriD : String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        self.FBConnet.updateOnline(online: "online")
        self.FBConnet.isInChatPage(ischat: false)
        self.FBConnet.getuserList { (userlist) in
            log.info("\(userlist)")
            self.userList = userlist
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        log.debug("myid\(UserDefaults.standard.value(forKey: R.userDefaultsKey.myid.rawValue) as? String ?? "")")
        self.useriD = UserDefaults.standard.value(forKey: R.userDefaultsKey.myid.rawValue) as? String ?? ""
        
        self.setupDelegate()
        self.setupAction()
    }
    
    
    func setupAction(){
        petUserView.chatIcon.addAction(for: .tap) {
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            let vc = UserVC.initWithStoryBoard()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}



extension PetDatingVC : UITableViewDelegate , UITableViewDataSource{
    
    func setupDelegate(){
        petUserView.petUserTable.register(nip: NibName.PetCell.rawValue, as: CellIdentifiers.petUserCell.rawValue)
        petUserView.petUserTable.delegate = self
        petUserView.petUserTable.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.chatVM?.numberOfRowsInSection(section) ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.petUserCell.rawValue, for: indexPath) as! PetUserCell
        cell.setupData(useriD: self.useriD, self.chatVM!.userAtIndex(indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatVC.initWithStoryBoard()
        vc.modalPresentationStyle = .fullScreen
        vc.userDetail = self.userList[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if DeviceType.IS_IPAD || DeviceType.IS_IPAD_PRO{
            return 150
        }else{
            return 85
        }
    }
    
    
}
