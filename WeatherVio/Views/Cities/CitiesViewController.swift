//
//  CitiesViewController.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/21/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {

    
    // MARK: - Variables -
    let vm = CitiesViewModel()
    
    
    
    // MARK: - Outlets -
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    // MARK: - Flow -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor(named: user_default.color!)
        collectionView.reloadData()
        vm.fetchSavedCities()
    }

    
    
    
    // MARK: - Functions -
    private func setupUI() {
        // NavigationBar
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(named: user_default.color!)
        // CollectionView
        collectionView.alpha = 0
    }
    
    private func initVM() {
        vm.reloadCollectionViewClosure = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                UIView.animate(withDuration: 0.4) {
                    self.collectionView.alpha = 1
                }
            }
        }
        vm.fetchSavedCities()
    }
    
    
}




// MARK: - Collection View Delegate and Datasource
extension CitiesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard vm.countOfCells != nil else { return 0 }
        return vm.countOfCells!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells.addCity, for: indexPath) as! CityWeatherCollectionViewCell
        let city = vm.cityVM![indexPath.row]
        cell.current(temp: "\(city.temp!)º", condition: city.condation!, icon: city.icon!, minAndMax: "\(city.min!)º  \(city.max!)º", city: city.city!, pressure: "\(city.pressure!) hPa", humidity: "\(city.humidity!)%")
        cell.setDeleteButton(tag: indexPath.row, target: self, action: #selector(deleteButtonPressed(_:)))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width - 30, height: 220)
    }
    
    @objc func deleteButtonPressed(_ seneder: UIButton) {
        vm.deleteCityFromCoreData(row: seneder.tag)
    }
    
    
}
