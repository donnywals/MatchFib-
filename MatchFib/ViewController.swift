//
//  ViewController.swift
//  MatchFib
//
//  Created by Donny Wals on 30/05/16.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collectionView: UICollectionView!
    let grid = Grid(rows: 50, columns: 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        
        collectionView.frame = view.bounds
        collectionView.registerClass(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "buttonCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(collectionView.bounds.width/CGFloat(grid.columns),
                          collectionView.bounds.height/CGFloat(grid.rows))
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return grid.rows
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return grid.pointMatrix[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("buttonCell", forIndexPath: indexPath) as! ButtonCollectionViewCell
        
        cell.label.text = "\(grid.pointMatrix[indexPath.section][indexPath.row].value)"
        
        return cell
    }

}

