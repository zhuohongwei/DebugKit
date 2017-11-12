//
//  ViewController.swift
//  DebugKit
//
//  Created by Hong Wei Zhuo on 11/11/17.
//  Copyright © 2017 Zhuo Hong Wei. All rights reserved.
//

import UIKit

private let cellId = "cell"

class ViewController: UIViewController {

    private var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = 44
        
        view.addSubview(tableView)
        
        view.inspectWithLongPress()
        
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "this is sample text"
        return cell
    }
    
}
