//
//  ViewController.swift
//  swift-proj
//
//  Created by lan on 2021/4/15.
//

import UIKit

struct Item {
    var title: String
    var vc: UIViewController
}

class ViewController: UIViewController {

    let datas = [
        Item(title: "自定义button", vc: CustomButtonViewController()),
        Item(title: "cell 重用", vc: IndexTableViewController())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rxSwift = RxswiftTest()
        rxSwift.test()
        
        let tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "identifier")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "identifier")
        }
        let item = datas[indexPath.row]
        cell?.textLabel?.text = item.title
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = datas[indexPath.row]
        let vc = item.vc
        navigationController?.pushViewController(vc, animated: true)
    }
}

