//
//  ListListViewController.swift
//  geoWeather
//
//  Created by sapgv on 01/02/2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, ListViewInput, UITableViewDelegate, UITableViewDataSource {

    var output: ListViewOutput!
    var location: Location!
    var listData: [List] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ListModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
        configureTableView()
        
        update()
        
    }

    @objc func update() {
        output.fetchListForLocation(location)
    }

    // MARK: ListViewInput
    func setupInitialState() {
    }
    
    func didFoundListData(_ listData: [List]) {
        self.listData = listData
        tableView.refreshControl?.endRefreshing()
    }
    
    
}

extension ListViewController {
    
    func configureTableView() {
        
        tableView.refreshControl = UIRefreshControl()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl?.addTarget(self, action: #selector(ListViewController.update), for: .valueChanged)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListCell
        
        let list = listData[indexPath.row]
        cell?.setup(list)
        
        return cell!
    }
}
