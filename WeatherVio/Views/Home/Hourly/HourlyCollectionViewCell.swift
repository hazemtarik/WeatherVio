//
//  HourlyTableViewCell.swift
//  WeaterVio
//
//  Created by Hazem Tarek on 8/19/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    // MARK:- Variables -
    var hourly = [HourlyViewModel]()
    
    
    // MARK:- Outlets -
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK:- Flow -
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate     = self
        collectionView.dataSource   = self
    }

}





// MARK:- Collection view datasource and delegate -
extension HourlyCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourly.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells.hourly, for: indexPath) as! HourCollectionViewCell
        cell.hourVM = hourly[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 75, height: 110)
    }
    
}

