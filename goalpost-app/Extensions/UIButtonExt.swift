//
//  UIButtonExt.swift
//  goalpost-app
//
//  Created by Mostafa Alaa on 8/28/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit
extension UIButton{
    
    func setSelectedColor(){
        self.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1)
    }
    func setDeselctedColor(){
        self.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 0.5204141695)
    }
}
