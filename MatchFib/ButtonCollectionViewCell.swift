//
//  ButtonCollectionViewCell.swift
//  MatchFib
//
//  Created by Donny Wals on 30/05/16.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    let label = UILabel(frame: CGRectZero)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        addSubview(label)
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(18)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if self.focused {
            self.backgroundColor = UIColor.whiteColor()
        } else {
            self.backgroundColor = UIColor.clearColor()
        }
    }
    
    func blink(style: BlinkStyle) {
        if style == .Update {
            self.backgroundColor = UIColor.yellowColor()
        } else if style == .Reset {
            self.backgroundColor = UIColor.greenColor()
        }
    }
}
