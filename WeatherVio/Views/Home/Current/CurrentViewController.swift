//
//  ViewController.swift
//  WeaterVio
//
//  Created by Hazem Tarek on 8/19/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import UIKit

class CurrentViewController: UIViewController {
    
    
    // MARK:- Variables -
    let vm = WeatherViewModel()
    
    
    
    // MARK:- Oultlets -
    @IBOutlet weak var spinnerView: SpinnerView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tryButton: UIButton!
    
    
    
    // MARK:- Flow -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNotification()
        initVM()
    }
    
    
    // MARK:- Functions -
    private func setupUI() {
        // Spinner
        spinnerView.animate()
        // CollectionView
        collectionView.alpha = 0
        //Message View
        messageView.alpha = 0
        tryButton.backgroundColor = UIColor(named: user_default.color!)
        // TabBar
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.tintColor = UIColor(named: user_default.color!)
    }
    
    
    private func initVM() {
        // Reload collectionView when get weather data
        vm.reloadWeatherClosure = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                UIView.animate(withDuration: 0.4) {
                    self.collectionView.alpha = 1
                    self.messageView.alpha = 0
                    self.spinnerView.alpha = 0
                    self.tabBarController?.tabBar.isHidden = false
                }
            }
        }
        // Display location validation message from coreLocation Service
        vm.showLocationMessageClosure = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                UIView.animate(withDuration: 0.4) {
                    self.spinnerView.alpha = 0
                    self.showMessageView(message: self.vm.locationMessage!, imageName: imagesName.locationAuth)
                }
            }
        }
        // Display Error message from API and Connection
        vm.showErrorMessageClosure = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                UIView.animate(withDuration: 0.4) {
                    self.spinnerView.alpha = 0
                    if self.vm.errorMessage == ErrorHandler.offline.localizedDescription {
                        self.showMessageView(message: self.vm.errorMessage!, imageName: imagesName.noInernet)
                    } else { self.showMessageView(message: self.vm.errorMessage!, imageName: imagesName.somthingWrong)}
                    
                }
            }
        }
        //vm.initFetchWeather() // Fetching weather data
    }
    
    
    // Factoring to error message
    private func showMessageView(message: String, imageName: String) {
        collectionView.alpha = 0
        messageView.alpha = 1
        messageLabel.text = message
        imageView.image = UIImage(named: imageName)
    }
    
    
    // Pressing try button to fetching again
    @IBAction func tryButtonPressed(_ sender: UIButtonX) {
        //vm.initFetchWeather()
    }
    
    
    // Configure Notifiection to detect if app come from Foreground
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector:#selector(comeFromBackground), name: UIApplication.willEnterForegroundNotification, object: UIApplication.shared)
        NotificationCenter.default.addObserver(self, selector: #selector(colorChanged), name: NSNotification.Name(rawValue: notificationName.changeColor), object: nil)    }
    
    
    // Fetch weather data when app come from Foreground
    @objc private func comeFromBackground() {
        vm.initFetchWeather()
    }
    
    
    // Reload CollectionView to apply cahanges
    @objc private func colorChanged() {
        collectionView.reloadData()
        tabBarController?.tabBar.tintColor = UIColor(named: user_default.color!)
        tryButton.backgroundColor = UIColor(named: user_default.color!)
    }
}









// MARK:- Collection view datasource and delegate -
extension CurrentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cells.header, for: indexPath) as! HeaderCollectionReusableView
        if indexPath.section == 0 || indexPath.section == 1 {
            section.title.text = "Next hours for today"
            return section
        } else {
            section.title.text = "Next 8 Days"
            return section
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = UIScreen.main.bounds.width - 30
        return section == 0 ? .zero : .init(width: width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let _ = vm.weatherVM else { return 0 }
        if section == 0 || section == 1 {
            return 1
        } else {
            return vm.countOfDays
        }
    }
    
    
    
    // Cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        if  section == 0 {
            let currentCell = collectionView.dequeueReusableCell(withReuseIdentifier: cells.current, for: indexPath) as! CurrentCollectionViewCell
            let current = vm.weatherVM!
            currentCell.current(date: "\(current.day!). \(current.date!)", temp: "\(current.temp!)º", condition: current.condation!, icon: current.icon!, minAndMax: "\(current.min!)º  \(current.max!)º", city: current.city!, unit: current.unit!, pressure: "\(current.pressure!) hPa", humidity: "\(current.humidity!)%")
            currentCell.unitSegment.addTarget(self, action: #selector(unitSegmentPressed), for: .valueChanged)
            currentCell.menuButton.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
            return currentCell
            
        } else if section == 1 {
            let hourlyCell = collectionView.dequeueReusableCell(withReuseIdentifier: cells.hourly, for: indexPath) as! HourlyCollectionViewCell
            hourlyCell.hourly = vm.weatherVM!.hourly!
            hourlyCell.collectionView.reloadData()
            return hourlyCell
            
        } else {
            let dailyCell = collectionView.dequeueReusableCell(withReuseIdentifier: cells.daily, for: indexPath) as! DayCollectionViewCell
            dailyCell.dayVM = vm.weatherVM!.daily![indexPath.row]
            return dailyCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        vm.initFetchWeather()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 30
        return indexPath.section == 0 ? .init(width: width, height: 347) : indexPath.section == 1 ? .init(width: width, height: 110): .init(width: (width) / 3, height: 170)
    }
    
    
    // MARK:- Send to view model selected unit by index of segment control
    @objc private func unitSegmentPressed(_ sender: UISegmentedControl) {
        vm.changeUnit(index: sender.selectedSegmentIndex)
        vm.initFetchWeather()
    }
    
    
    // MARK:- Present Menu view controller
    @objc private func menuButtonPressed() {
        let vc = storyboard?.instantiateViewController(withIdentifier: stroryBoard.settings)
        present(vc!, animated: true)
    }
}


