//
//  DynamicHeaderView.swift
//  DynamicHeaderApp
//
//  Created by Wendell Thompson on 6/17/16.
//  Copyright © 2016 Wendell. All rights reserved.
//

import UIKit

public class DynamicHeaderView: UIScrollView {
    
    private static let MinHeaderHeight: CGFloat = 100.0
    private static let MaxHeaderHeight: CGFloat = 320.0
    private static let SeparatorHeight: CGFloat = 100.0
    
    public var backgroundView: UIView? {
        willSet {
            self.backgroundView?.removeFromSuperview()
        }
        didSet {
            guard let bgView = self.backgroundView else { return }
            self.insertSubview(bgView, atIndex: 0)
            self.setNeedsLayout()
        }
    }
    
    private weak var headerView: UIView?
    private weak var separatorView: UIView?
    private weak var contentContainerView: UIView?
    private weak var contentClipView: UIView?
    private weak var contentView: UIView?
    
    private var headerOffsetY: CGFloat {
        return self.contentOffset.y
    }
    
    private var headerHeight: CGFloat {
        let height = DynamicHeaderView.MaxHeaderHeight - self.contentOffset.y
        return height < DynamicHeaderView.MinHeaderHeight ?
            DynamicHeaderView.MinHeaderHeight :
            height
    }
    
    public override func awakeFromNib() {
        
        self.clipsToBounds = true
        
        let header = UIView()
        header.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        self.addTestLabel(header, text: "Header")
        
        let separator = UIView()
        separator.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        self.addTestLabel(separator, text: "Separator")
        
        let contentContainer = UIView()
        contentContainer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        
        // MARK: Test Code
        var views: [UIView] = []
        for index in 0 ..< 10 {
            let label = UILabel()
            label.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.25)
            label.text = "Label \(index + 1)"
            label.textAlignment = .Center
            label.textColor = .whiteColor()
            views.append(label)
        }
        
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .Vertical
        stackView.distribution = .FillEqually
        contentContainer.addSubview(stackView)
        stackView.addFillConstraints()
        // MARK: End Test Code
        
        let contentClip = UIView()
        contentClip.clipsToBounds = true
        contentClip.backgroundColor = .clearColor()
        contentClip.addSubview(contentContainer)
        
        let content = UIView()
        content.backgroundColor = .clearColor()
        content.addSubview(contentClip)
        
        self.addSubviews(content, separator, header)
        
        self.headerView = header
        self.separatorView = separator
        self.contentView = content
        self.contentClipView = contentClip
        self.contentContainerView = contentContainer
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let backgroundFrame = CGRect(
            x: 0.0,
            y: self.contentOffset.y,
            width: self.bounds.width,
            height: self.bounds.height)
        
        let headerFrame = CGRect(
            x: 0.0,
            y: self.headerOffsetY,
            width: self.bounds.width,
            height: self.headerHeight
        )
        
        let separatorFrame = CGRect(
            x: 0.0,
            y: headerFrame.maxY,
            width: self.bounds.width,
            height: DynamicHeaderView.SeparatorHeight
        )
        
        let contentFrame = CGRect(
            x: 0.0,
            y: DynamicHeaderView.MaxHeaderHeight + DynamicHeaderView.SeparatorHeight,
            width: self.bounds.width,
            height: self.bounds.height - (DynamicHeaderView.MinHeaderHeight + DynamicHeaderView.SeparatorHeight)
        )
        
        let clipMinY = separatorFrame.maxY - contentFrame.minY
        let contentClipFrame = CGRect(
            x: 0.0,
            y: clipMinY,
            width: self.bounds.width,
            height: contentFrame.height - clipMinY)
        
        let containerFrame = CGRect(
            x: 0.0,
            y: (clipMinY * -1.0),
            width: self.bounds.width,
            height: contentFrame.height)
        
        let scrollContentSize = CGSize(
            width: self.bounds.width,
            height: self.bounds.height + (DynamicHeaderView.MaxHeaderHeight - DynamicHeaderView.MinHeaderHeight)
        )
        
        self.backgroundView?.frame = backgroundFrame
        self.headerView?.frame = headerFrame
        self.separatorView?.frame = separatorFrame
        self.contentContainerView?.frame = containerFrame
        self.contentClipView?.frame = contentClipFrame
        self.contentView?.frame = contentFrame
        self.contentSize = scrollContentSize
    }
    
    private func addTestLabel(view: UIView, text: String) {
        
        let lbl = UILabel()
        lbl.text = text
        lbl.textColor = .whiteColor()
        lbl.textAlignment = .Center
        view.addSubview(lbl)
        lbl.addFillConstraints()
    }
}

