//
//  Extensions.swift
//  Ing Task
//
//  Created by Bilgehan Senay on 7.11.2020.
//  Copyright © 2020 Bilgehan Senay. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Realm

extension UIView {
   func corneredRadius(radius:CGFloat)
    {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func borderedColor(color:UIColor,width:CGFloat)
    {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }

}


extension UILabel{
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}

extension String{
    func calculateTitleHeight(labelWidth: CGFloat) -> Int{
        let maxSize = CGSize(width: labelWidth, height: CGFloat(Float.infinity))
        let charSize = 17.900390625
        let text = (self) as NSString
        let font = UIFont(name: ".SFUIText-Bold", size: 15.0)
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/CGFloat(charSize)))
        return Int(linesRoundedUp * 18)
    }
    
    
}
