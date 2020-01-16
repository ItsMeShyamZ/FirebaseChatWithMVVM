//
//  UXImageView.swift
//  FireBaseChat
//
//  Created by Abservetech on 09/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import UIKit

class SZImageView : UIImageView{
    
    // MARK: - <# Circle Image #>
    
    @IBInspectable var CornerRadius : Int = 10 {
        didSet{
            self.layer.cornerRadius = CGFloat(CornerRadius)
        }
    }
    
    @IBInspectable var change_image:Bool = false
    
    override func awakeFromNib() {
        Color()
    }
    func Color(){
        if change_image{
            self.image = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        }
    }
  
}


extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
}


extension UIImageView{
    
      public var isCircleview : Bool{
            get{
                return self.layer.cornerRadius > 0
            }
            set(value){
                if value{
                    self.layer.cornerRadius = self.bounds.width/2
                }
            }
       }
    
    func getImageFromString(_ imageview : UIImageView , imageurl : String){
        if let _ : URL = URL(string: imageurl){
            
            let url = URL(string: imageurl)!
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil{
                    log.error("\(String(describing: error))")
                    return
                }
                DispatchQueue.main.sync {
                    imageview.image = UIImage(data: data ?? Data())
                }
            }.resume()
            
        }
    }
}
