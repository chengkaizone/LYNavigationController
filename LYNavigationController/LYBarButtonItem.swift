//
//  LYBarButtonItem.swift
//  LYNavigationController
//
//  Created by joinhov on 16/2/2.
//  Copyright © 2016年 lance. All rights reserved.
//

import UIKit

class LYBarButtonItem: UIButton {

    class func buttonWithTitle(_ title: String) ->LYBarButtonItem {
        
        let barButtonItem = LYBarButtonItem(type: .custom)
        
        let font = UIFont.boldSystemFont(ofSize: 17.0)
        var buttonSize = (title as NSString).size(attributes: [NSFontAttributeName:font])
        if buttonSize.width > 68 {
            buttonSize.width = 68
        }
        
        barButtonItem.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        barButtonItem.frame = CGRect(x: 0, y: 0, width: buttonSize.width, height: 33)
        barButtonItem.setTitle(title, for: UIControlState())
        barButtonItem.tintColor = UIColor.white
        barButtonItem.titleLabel?.font = font
        
        return barButtonItem
    }
    
    class func buttonWithImage(_ imageNormal: UIImage?, imageSelected: UIImage?) ->LYBarButtonItem {
        
        let barButtonItem = LYBarButtonItem(type: .custom)
        barButtonItem.frame = CGRect(x: 0, y: 0, width: 33, height: 33)
        barButtonItem.setImage(imageNormal, for: UIControlState())
        barButtonItem.setImage(imageSelected, for: .highlighted)
        
        return barButtonItem
    }
    

}
