//
//  UXLable.swift
//  FireBaseChat
//
//  Created by Abservetech on 09/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import UIKit



@IBDesignable class SZLable : UILabel{
    
    // MARK: -  <# Rounded Corner Label #>
    
    @IBInspectable var CornerRadius : Int = 10 {
        didSet{
            self.layer.cornerRadius = CGFloat(CornerRadius)
        }
        
    }
    

    
    @IBInspectable var shadowColors : UIColor = UIColor.black{
        didSet{
            self.layer.shadowColor = shadowColors.cgColor
        }
    }
    
    
    @IBInspectable var shadowRadius : CGFloat = 0{
        didSet{
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    
    @IBInspectable var shadowOffsets : CGSize = CGSize(width: 0, height: 0){
        didSet{
            self.layer.shadowOffset = shadowOffsets
        }
    }
    
     @IBInspectable var shadowOpacity : Float = 0{
          didSet{
              self.layer.shadowOpacity = shadowOpacity
          }
      }
 
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0
    
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
}

extension UILabel {
      public var isCircleview : Bool{
              get{
                  return self.layer.cornerRadius > 0
              }
              set(value){
                  if value{
                      self.layer.masksToBounds = true
                      self.layer.cornerRadius = self.bounds.width/2
                  }
              }
         }
    
    
    public var isElevations : Bool {
              get{
                  return true
              }
              set(value){
                  if value{
                      self.layer.shadowColor = UIColor.black.cgColor
                      self.layer.shadowRadius = 5
                      self.layer.shadowOffset = CGSize(width: 1, height: 1)
                    self.layer.shadowOpacity = 0.3
                  }
              }
          }
}
