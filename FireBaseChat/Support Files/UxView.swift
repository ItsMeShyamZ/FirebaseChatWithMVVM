//
//  UZView.swift
//  FireBaseChat
//
//  Created by Abservetech on 09/01/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import UIKit
@IBDesignable
class SZView : UIView{
   // MARK: -  <# Rounded Corner Label #>
        
        @IBInspectable var CornerRadius : Int = 10 {
            didSet{
                self.layer.cornerRadius = CGFloat(CornerRadius)
            }
        }
    
    
        
        @IBInspectable var shadowColor : UIColor = UIColor.black{
            didSet{
                self.layer.shadowColor = shadowColor.cgColor
            }
        }
        
        
        @IBInspectable var shadowRadius : CGFloat = 0{
            didSet{
                self.layer.shadowRadius = shadowRadius
            }
        }
        
        
        @IBInspectable var shadowOffset : CGSize = CGSize(width: 0, height: 0){
            didSet{
                self.layer.shadowOffset = shadowOffset
            }
        }
        
         @IBInspectable var shadowOpacity : Float = 0{
              didSet{
                  self.layer.shadowOpacity = shadowOpacity
              }
          }
        
        
    }

    extension UIView {
          public var isCircleView : Bool{
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
        
        // MARK: - <# Rounded Corner with border #>
        
        public func roundedCornerBorder(width value : Int , _ color : UIColor){
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = CGFloat(value)
            self.layer.cornerRadius = 20
        }
        
        
        public var isElevation : Bool {
            get{
                return true
            }
            set(value){
                if value{
                    self.layer.shadowColor = UIColor.black.cgColor
                    self.layer.shadowRadius = 10
                    self.layer.shadowOffset = CGSize(width: 1, height: 1)
                    self.layer.shadowOpacity = 0.5
                }
            }
        }
        
        
        func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
            self.clipsToBounds = true
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
           }
        
        public var isError : Bool {
                get{
                    return true
                }
                set(value){
                    if value{
                        self.layer.shadowColor = UIColor.red.cgColor
                        self.layer.shadowRadius = 5
                        self.layer.shadowOffset = CGSize(width: 1, height: 1)
                        self.layer.shadowOpacity = 0.5
                    }
                }
            }
    }
