//
//  LYBarButtonItem.swift
//  LYNavigationController
//
//  Created by joinhov on 16/2/2.
//  Copyright © 2016年 lance. All rights reserved.
//

import UIKit

class LYBarButtonItem: UIButton {

    class func buttonWithTitle(title: String) ->LYBarButtonItem {
        
        let barButtonItem = LYBarButtonItem(type: .Custom)
        
        let font = UIFont.boldSystemFontOfSize(17.0)
        var buttonSize = (title as NSString).sizeWithAttributes([NSFontAttributeName:font])
        if buttonSize.width > 68 {
            buttonSize.width = 68
        }
        
        barButtonItem.titleLabel?.lineBreakMode = NSLineBreakMode.ByClipping
        barButtonItem.frame = CGRectMake(0, 0, buttonSize.width, 33)
        barButtonItem.setTitle(title, forState: .Normal)
        barButtonItem.tintColor = UIColor.whiteColor()
        barButtonItem.titleLabel?.font = font
        
        return barButtonItem
    }
    
    class func buttonWithImage(imageNormal: UIImage?, imageSelected: UIImage?) ->LYBarButtonItem {
        
        let barButtonItem = LYBarButtonItem(type: .Custom)
        barButtonItem.frame = CGRectMake(0, 0, 33, 33)
        barButtonItem.setImage(imageNormal, forState: .Normal)
        barButtonItem.setImage(imageSelected, forState: .Highlighted)
        
        return barButtonItem
    }
    

}
