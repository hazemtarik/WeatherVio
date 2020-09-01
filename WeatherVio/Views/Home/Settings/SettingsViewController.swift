//
//  SettingsViewController.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/30/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    // MARK: - Variables -
    let colors = ["0", "1", "2", "3", "4", "5", "6", "7"]
    
    
    // MARK: - Outlets -
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    // MARK: - Flow -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    
    // MARK: - Functions -
    private func setupUI() {
        // NavigationBar
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(named: user_default.color!)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName.changeColor), object: nil)
        dismiss(animated: true)
    }
    
    
    @IBAction func CancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}




// MARK: - Collection view datasource and delegate -
extension SettingsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cells.header, for: indexPath) as! HeaderCollectionReusableView
        section.title.text = "Choose which color would you like:"
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let colorCell = collectionView.dequeueReusableCell(withReuseIdentifier: cells.colors, for: indexPath) as! ColorCollectionViewCell
        colorCell.setupColorView(named: colors[indexPath.row])
        return colorCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 3
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaults.standard.setValue(colors[indexPath.row], forKey: userDefaultsKeys.color)
        navigationController?.navigationBar.tintColor = UIColor(named: colors[indexPath.row])
        collectionView.reloadData()
    }
    
}
