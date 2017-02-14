//
//  LYNavigationBar.swift
//  LYNavigationController
//
//  Created by joinhov on 16/2/2.
//  Copyright © 2016年 lance. All rights reserved.
//

import UIKit


///
open class LYNavigationBar: UIView {
    
    fileprivate let navigationBarHeight: CGFloat = 64
    
    fileprivate var barLine: UIView!
    open var title: String! {
        didSet {
            guard let title = title, titleLabel != nil else {
                return
            }
            
            titleLabel.text = title
        }
    }
    open var titleLabel: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup(frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let screenSize = UIScreen.main.bounds.size
        
        let frame = CGRect(x: 0, y: 0, width: screenSize.width, height: navigationBarHeight)
        setup(frame)
    }
    
    func setup(_ frame: CGRect) {
        
        let screenSize = UIScreen.main.bounds.size
        
        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: navigationBarHeight)
        self.backgroundColor = UIColor(white: 0.960, alpha: 1.0)
        
        
        barLine = UIView(frame: CGRect(x: 0, y: navigationBarHeight - 1, width: screenSize.width, height: 1))
        barLine.backgroundColor = UIColor(white: 0.639, alpha: 1.0)
        self.addSubview(barLine)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 100, height: 43))
        titleLabel.text = self.title
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textColor = UIColor.black
        self.addSubview(titleLabel)
        
        titleLabel.center = CGPoint(x: self.center.x, y: titleLabel.center.y)
        
    }

}
