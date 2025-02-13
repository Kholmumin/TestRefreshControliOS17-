//
//  ViewController.swift
//  Test17+RefreshControll
//
//  Created by Kholmumin Tursinboev on 2/11/25.
//

import UIKit

class ViewController: UITableViewController {
    private var onViewIsAppearing: ((ViewController) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        onViewIsAppearing = { vc in
            vc.refresh()
            vc.onViewIsAppearing = nil
        }
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        onViewIsAppearing?(self)
    }

    @objc private func refresh(){
        refreshControl?.beginRefreshing()
    }

}

