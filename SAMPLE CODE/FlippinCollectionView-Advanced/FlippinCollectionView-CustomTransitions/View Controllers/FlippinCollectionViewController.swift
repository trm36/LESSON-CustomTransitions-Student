//
//  FlippinCollectionViewController.swift
//  FlippinCollectionView-CustomTransitions
//
//  Created by Taylor Mott on 04-Oct-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

private let colors = [Color(), Color(), Color()]

class FlippinCollectionViewController: UICollectionViewController {
    
    static let cellDimension = CGFloat(300.0)
    
//    var selectedItemIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.isPagingEnabled = true
        setupFlowLayoutForViewSize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View Modifying Methodsany
    
    func setupFlowLayoutForViewSize() {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let topBottomInsetValue = (view.frame.height - FlippinCollectionViewController.cellDimension) / 2.0
        let leftRightInsetValue = (view.frame.width - FlippinCollectionViewController.cellDimension) / 2.0
        flowLayout.sectionInset = UIEdgeInsets(top: topBottomInsetValue, left: leftRightInsetValue, bottom: topBottomInsetValue, right: leftRightInsetValue)
        flowLayout.minimumLineSpacing = leftRightInsetValue * 2.0
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            guard let destinationVC = segue.destination as? DetailViewController,
                let collectionView = collectionView,
                let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
                let selectedIndexPath = selectedIndexPaths.first else { return }
            
            destinationVC.color = colors[selectedIndexPath.item]
            destinationVC.transitioningDelegate = destinationVC
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.reuseIdentifier, for: indexPath) as! LabelCollectionViewCell
        
        let color = colors[indexPath.item]
        
        cell.label.text = color.dateString
        cell.contentView.backgroundColor = color.uiColor
        
        return cell
    }
}
