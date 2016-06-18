//
//  ViewController.swift
//  DynamicHeaderApp
//
//  Created by Wendell Thompson on 6/17/16.
//  Copyright © 2016 Wendell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "dh_background"))
        imageView.contentMode = .ScaleAspectFill
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        blurView.alpha = 0.5
        
        let bgView = UIView()
        bgView.addSubview(imageView)
        bgView.addSubview(blurView)
        
        [imageView, blurView].forEach { v in v.addFillConstraints() }
        
        let headerView: DynamicHeaderView = UIView.fromNib("DynamicHeaderView")
        headerView.backgroundView = bgView
        self.view.addSubview(headerView)
        headerView.addFillConstraints(topGuide: self.topLayoutGuide)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

