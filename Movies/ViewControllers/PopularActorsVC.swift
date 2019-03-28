//
//  PopularActorsVC.swift
//  Movies
//
//  Created by mahmoud fekry on 3/28/19.
//  Copyright © 2019 mahmoud fekry. All rights reserved.
//

import UIKit

class PopularActorsVC: UIViewController {
    @IBOutlet weak var myCollectionViewOutlet: UICollectionView!
    @IBOutlet weak var mysearchOutlet: UISearchBar!
    
    var actors = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()

     }
    
    
    func setupSearch(){
        mysearchOutlet.showsCancelButton = true
        for subView in mysearchOutlet.subviews {
            for subViewInSubView in subView.subviews {
                if subViewInSubView.isKind(of : UITextField.self) {
                    subViewInSubView.backgroundColor = UIColor.groupTableViewBackground
                }
            }
        }
    }
}

// MARK: my collection view protocols implimentation
extension PopularActorsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        //(cell.viewWithTag(1) as! UIImageView).image =
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2.28, height: UIScreen.main.bounds.width / 2.28)
    }
}

// MARK: my search protocols implimentation
extension PopularActorsVC:UISearchBarDelegate,UISearchDisplayDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        myCollectionViewOutlet.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.text = ""
    }
}
