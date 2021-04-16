//
//  IndexTableView.swift
//  IndexBar
//
//  Created by lan on 2021/3/16.
//

import UIKit

protocol IndexTableViewDataSource {
    func indexTitlesForIndexTableView(tableView: UITableView) -> Array<String>?
}

class IndexTableView: UITableView {
    public var indexDataSource: IndexTableViewDataSource?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        self.superview?.insertSubview(view, aboveSubview: self)
        return view
    }()
    
    private var reusePool: ViewReusePool = ViewReusePool()
    
    override func reloadData() {
        super.reloadData()
        
        self.reusePool.reset()
        
        self.reloadIndexBar()
    }
    
    func reloadIndexBar() -> Void {
        guard let arrayTitles = self.indexDataSource?.indexTitlesForIndexTableView(tableView: self), arrayTitles.count >= 0 else {
            self.containerView.isHidden = true
            return
        }
        
        let count = arrayTitles.count
        let buttonWidth = 60
        let buttonHeight = Int(self.frame.size.height / CGFloat(count))
        for i in 0..<count {
            let title = arrayTitles[i]
            var button = reusePool.dequeueReusableView() as? UIButton
            if button == nil {
                button = UIButton()
                button?.backgroundColor = UIColor.white
                reusePool.addUsingView(button)
                print("create a button")
            } else {
                print("reuse button")
            }
            
            self.containerView.addSubview(button!)
            button!.setTitle(title, for: .normal)
            button!.setTitleColor(UIColor.black, for: .normal)
            button?.frame = CGRect(x: 0, y: i * buttonHeight, width: buttonWidth, height: buttonHeight)
        }
        
        containerView.isHidden = false
        containerView.frame = CGRect(x: self.frame.origin.x + self.frame.size.width - CGFloat(buttonWidth), y: self.frame.origin.y, width: CGFloat(buttonWidth), height: self.frame.size.height)
    }

}
