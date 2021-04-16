//
//  CustomButtonViewController.swift
//  swift-proj
//
//  Created by lan on 2021/4/16.
//

import UIKit

class CustomButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = CustomButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(self.doAction), for: .touchUpInside)
        self.view.addSubview(button)
        
        let button2 = UIButton(type: .custom)
        button2.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        button2.backgroundColor = UIColor.yellow
        button2.addTarget(self, action: #selector(self.doAction2), for: .touchUpInside)
        
        button.addSubview(button2)
    }
    
    @objc func doAction() -> Void {
        print("---> doAction")
    }

    @objc func doAction2() -> Void {
        print("+++> doAction2")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
