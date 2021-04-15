//
//  ViewController.swift
//  swift-proj
//
//  Created by lan on 2021/4/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let rxSwift = RxswiftTest()
        rxSwift.test()
    }
}

