//
//  ViewController.swift
//  Test17+RefreshControll
//
//  Created by Kholmumin Tursinboev on 2/11/25.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        refresh()
    }

    @objc private func refresh(){
        refreshControl?.beginRefreshing()
    }

}

