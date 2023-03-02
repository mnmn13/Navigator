//
//  MainViewController.swift
//  NavigatorApp
//
//  Created by MN on 28.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    
    var viewModel: MainViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        bind()
        viewModel.loadInfo()
        viewModel.fetchFromDatabase()
        setupRefresh()
    }
    
    func bind() {
        viewModel.onReload = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func setupTV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Loading")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.fetchFromDatabase()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    @IBAction func startMonitoringTapped(_ sender: UIButton) {
        statusLabel.text = viewModel.startMonitor()
    }
    @IBAction func stopMonitoringTapped(_ sender: UIButton) {
        statusLabel.text = viewModel.stopMonitor()
    }
    @IBAction func showOnMapTapped(_ sender: UIButton) {
        viewModel.showMap()
    }
    @IBAction func logoutTapped(_ sender: UIButton) {
        viewModel.logout()
    }
    
    @IBAction func navigatorTapped(_ sender: Any) {
    }
    
    @IBAction func clearTapped(_ sender: Any) {
        statusLabel.text = viewModel.eraseDataBase()
    }
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = viewModel.getCellForRowAt(indexPath: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = "Time: \(model.date), lat: \(model.lat), lon: \(model.lon)"
        cell.contentConfiguration = content
        return cell
        
    }
}
