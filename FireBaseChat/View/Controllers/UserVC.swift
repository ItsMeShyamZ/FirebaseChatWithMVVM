//
//  UserVC.swift
//  FireBaseChat
//
//  Created by Abservetech on 11/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import UIKit

class UserVC: UIViewController {
    
    // MARK: - <# VC initializer #>
    
    class func initWithStoryBoard() -> UserVC{
        let vc = UIStoryboard(name: StoryBoardName.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: IDName.UserVC.rawValue) as! UserVC
        return vc
    }
    
    @IBOutlet weak var userImage : UIImageView!
    @IBOutlet weak var userName : UITextField!
    @IBOutlet weak var error : UILabel!
    @IBOutlet weak var submitBtn : UIButton!
    
    var FBConnect = FireBaseconnection.instanse
    var userCount : Int = Int()
    
    var pickImage : UIImagePickerController? =  UIImagePickerController()
    var imagetopost = UIImage()
    var isImageUpload = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickImage?.delegate = self
        pickImage?.allowsEditing = true
        userName.delegate = self
        
        self.FBConnect.getUserCount { (userCount) in
            self.userCount = userCount
        }
        
        self.setupAction()
    }
    
    func setupAction(){
        
        
        
        self.userImage.addAction(for: .tap) {
            self.pickProfileImage()
        }
        
        self.submitBtn.addAction(for: .tap) {
            self.view.endEditing(true)
            let name = self.userName.text ?? ""
            if self.isImageUpload == false && name.isEmpty{
                self.error.isHidden = false
                self.error.text = "First Enter name and upload image"
            }else{
                if self.isImageUpload == false{
                    self.error.isHidden = false
                    self.error.text = "First upload image"
                }else{
                    if !name.isEmpty{
                        self.error.isHidden = true
                        let random = String(format:"%04d", arc4random_uniform(10000) )
                        self.FBConnect.uploadeImage(userImage: self.imagetopost, userid: random, name: name,added: { _ in
                            UserDefaults.standard.set(random, forKey: R.userDefaultsKey.myid.rawValue)
                            let vc = PetDatingVC.initWithStoryBoard()
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        })
                        
                    }else{
                        self.error.isHidden = false
                        self.error.text = "First Enter name"
                    }
                }
            }
            
        }
        
    }
}

extension UserVC : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}



//Image Picker
extension UserVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func pickProfileImage(){
        
        let imageEdit = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        imageEdit.modalPresentationStyle = .popover
        imageEdit.addAction(UIAlertAction(title: "Take Photos", style: .default, handler: { (photo) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                DispatchQueue.main.async(execute: {
                    self.pickImage?.sourceType = UIImagePickerController.SourceType.camera
                    self.pickImage?.mediaTypes = ["public.image"]
                    if UIImagePickerController.isCameraDeviceAvailable(.front) {
                        self.pickImage?.cameraDevice = .front
                    }
                    else {
                        self.pickImage?.cameraDevice = .rear
                    }
                    self.present(self.pickImage!, animated: true, completion: nil)
                })
            }
        }))
        imageEdit.addAction(UIAlertAction(title: "Choose from gallery", style: .default, handler: { (photo) in
            self.pickImage?.allowsEditing = true
            self.pickImage?.sourceType = .photoLibrary
            self.present(self.pickImage!, animated: true, completion: nil)
        }))
        imageEdit.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_ ) in
        }))
        
        if let popview = imageEdit.popoverPresentationController{
            popview.sourceView = self.view
            popview.sourceRect = self.view.bounds
        }
        self.present(imageEdit, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        pickImage?.dismiss(animated: true, completion: nil)
        var imagetoupload :UIImage?
        
        if let image = info[.originalImage] as? UIImage {
            imagetoupload = image
        }
        
        if let image = info[.editedImage] as? UIImage {
            imagetoupload = image
        }
        
        if imagetoupload != nil {
            self.userImage.image = imagetoupload
            imagetopost = imagetoupload!
            self.isImageUpload = true
            self.error.isHidden = true
        }
    }
}

