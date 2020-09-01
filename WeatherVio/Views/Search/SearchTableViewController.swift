//
//  SearchTableViewController.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/21/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    // MARK: - Variables -
    let searchController = UISearchController()
    let vm               = SearchViewModel()
    
    
    
    
    // MARK: - Flow -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initVM()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor(named: user_default.color!)
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    
    
    
    // MARK: - Funcations -
    private func setupUI() {
        // NavigationBar
        navigationController?.navigationBar.shadowImage = UIImage()
        // Search Controller
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search by city"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        // Table View
        tableView.tableFooterView = UIView()
        definesPresentationContext = true
    }
    
    
    private func initVM() {
        vm.updateTableViewClosure = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    // MARK: - Table view data source -
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard vm.countOfCells != nil else { return 0}
        return vm.countOfCells!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < vm.countOfCells! else { return UITableViewCell() }
        let city = vm.resultVM![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cells.city, for: indexPath)
        cell.textLabel?.text = city.address!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        vm.selectedCell(row: indexPath.row)
        navigationController?.popToRootViewController(animated: true)
        return indexPath
    }
    
    
}




// MARK: - Search Controller Delegate -
extension SearchTableViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text
        guard text != "" || text != nil else { return }
        vm.beginSearch(city: text!)
    }
}
