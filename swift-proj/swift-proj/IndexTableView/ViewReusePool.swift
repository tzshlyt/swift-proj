//
//  ViewReusePool.swift
//  IndexBar
//
//  Created by lan on 2021/3/16.
//

import Foundation
import UIKit

class ViewReusePool: NSObject {
    private let waitUsedQueue: NSMutableSet = NSMutableSet()
    private let usingQueue: NSMutableSet = NSMutableSet()
    
    func dequeueReusableView() -> UIView? {
        let view = waitUsedQueue.anyObject() as? UIView
        guard view != nil else { return nil }
        
        waitUsedQueue.remove(view!)
        usingQueue.add(view!)
        return view
    }
    
    func addUsingView(_ view: UIView?) {
        guard view != nil else { return }
        usingQueue.add(view as Any)
    }
    
    func reset() {
        var view: UIView? = usingQueue.anyObject() as? UIView
        while view != nil {
            usingQueue.remove(view as Any)
            waitUsedQueue.add(view as Any)
            view = usingQueue.anyObject() as? UIView
        }
    }
}
