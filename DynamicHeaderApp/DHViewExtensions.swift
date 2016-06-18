//
//  DHViewExtensions.swift
//  DynamicHeaderApp
//
//  Created by Wendell Thompson on 6/17/16.
//  Copyright © 2016 Wendell. All rights reserved.
//

import UIKit

extension UIView {
    
    public func addSubviews(views: UIView ...) {
        views.forEach{ v in self.addSubview(v) }
    }
    
    public func addFillConstraints(insets: UIEdgeInsets = UIEdgeInsets(), topGuide: UILayoutSupport? = nil) {
        
        guard self.superview != nil else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let options: NSLayoutFormatOptions = []
        var views:[String: AnyObject] = ["view": self]
        var formats: [String] = ["H:|-\(insets.left)-[view]-\(insets.right)-|"]
        
        if let top = topGuide {
            views.updateValue(top, forKey: "top")
            formats.append("V:[top]-\(insets.top)-[view]-\(insets.bottom)-|")
        } else {
            formats.append("V:|-\(insets.top)-[view]-\(insets.bottom)-|")
        }
        
        let constraints = formats.flatMap { f in
            NSLayoutConstraint.constraintsWithVisualFormat(f, options: options, metrics: nil, views: views)
        }
        
        NSLayoutConstraint.activateConstraints(constraints)
        self.setNeedsLayout()
    }
    
    public class func fromNib<T: UIView>(nibName: String) -> T {
        let nibItems = NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil)
        let view: T? = nibItems.filter{ i in i is T }.first as? T
        return view!
    }
    
}
