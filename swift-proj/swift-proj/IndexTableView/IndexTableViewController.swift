//
//  IndexTableViewController.swift
//  swift-proj
//
//  Created by lan on 2021/4/16.
//

import UIKit

class IndexTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, IndexTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "reuseId"
        var cell = tableview.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func indexTitlesForIndexTableView(tableView: UITableView) -> Array<String>? {
        if self.change {
            self.change = false
            return Array(arrayLiteral: "A", "B", "C", "D", "E")
        } else {
            self.change = true
            return Array(arrayLiteral: "E", "F", "G", "Z")
        }
    }
    
    
    private lazy var tableview: IndexTableView = {
        let view = IndexTableView(frame: CGRect(x: 0, y: 60, width: self.view.frame.size.width, height: self.view.frame.size.height - 60), style: .plain)
        view.delegate = self
        view.dataSource = self
        view.indexDataSource = self
        
        return view
    }()
    
    private var change = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableview)
        
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: 40))
        button.backgroundColor = UIColor.red
        button.setTitle("reloadTable", for: .normal)
        button.addTarget(self, action: #selector(doAction), for: .touchUpInside)
        view.addSubview(button)
        
    }

    @objc func doAction() -> Void {
        self.tableview.reloadData()
    }
}
