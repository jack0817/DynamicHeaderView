//
//  DHArrayExtensions.swift
//  DynamicHeaderApp
//
//  Created by Wendell Thompson on 6/17/16.
//  Copyright © 2016 Wendell. All rights reserved.
//

import Foundation

extension Array {
    
    public func forEach(action: (Element) -> Void) {
        for e in self {
            action(e)
        }
    }
}