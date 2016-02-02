//
//  LYNavigationBar.swift
//  LYNavigationController
//
//  Created by joinhov on 16/2/2.
//  Copyright © 2016年 lance. All rights reserved.
//

import UIKit


///
public class LYNavigationBar: UIView {
    
    private let navigationBarHeight: CGFloat = 64
    
    private var barLine: UIView!
    public var title: String! {
        didSet {
            guard let title = title where titleLabel != nil else {
                return
            }
            
            titleLabel.text = title
        }
    }
    public var titleLabel: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup(frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let screenSize = UIScreen.mainScreen().bounds.size
        
        let frame = CGRectMake(0, 0, screenSize.width, navigationBarHeight)
        setup(frame)
    }
    
    func setup(frame: CGRect) {
        
        let screenSize = UIScreen.mainScreen().bounds.size
        
        self.frame = CGRectMake(0, 0, screenSize.width, navigationBarHeight)
        self.backgroundColor = UIColor(white: 0.960, alpha: 1.0)
        
        
        barLine = UIView(frame: CGRectMake(0, navigationBarHeight - 1, screenSize.width, 1))
        barLine.backgroundColor = UIColor(white: 0.639, alpha: 1.0)
        self.addSubview(barLine)
        
        titleLabel = UILabel(frame: CGRectMake(0, 20, 100, 43))
        titleLabel.text = self.title
        titleLabel.textAlignment = .Center
        titleLabel.lineBreakMode = .ByTruncatingTail
        titleLabel.textColor = UIColor.blackColor()
        self.addSubview(titleLabel)
        
        titleLabel.center = CGPointMake(self.center.x, titleLabel.center.y)
        
    }

}
