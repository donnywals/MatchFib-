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
            blinkWithColor(UIColor.yellowColor())
        } else if style == .Reset {
            blinkWithColor(UIColor.greenColor())
        }
    }
    
    func blinkWithColor(color: UIColor) {
        blinkAnimation({[weak self] in
                self?.backgroundColor = color
            }, completion: {[weak self] _ in
                let toColor = (self?.focused == true) ? UIColor.whiteColor() : UIColor.clearColor()
                self?.blinkAnimation({ self?.backgroundColor = toColor}, completion: nil)
            })
    }
    
    func blinkAnimation(animation: ()->Void, completion: ((Bool)->Void)?) {
        UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,
                                   options: [], animations: animation, completion: completion)
    }
}
