//
//  PopularActorsVC.swift
//  Movies
//
//  Created by mahmoud fekry on 3/28/19.
//  Copyright © 2019 mahmoud fekry. All rights reserved.
//

import UIKit
import Kingfisher
class PopularActorsVC: UIViewController {
    @IBOutlet weak var myCollectionViewOutlet: UICollectionView!
    @IBOutlet weak var mysearchOutlet: UISearchBar!
    
    var actors = [[String:Any]]()
    var actorsCopy = [[String:Any]]()
    var searchActive = false
    var pagingNum = "1"
    var total_pages = 0
    var url = "person/popular?api_key=10bcaef3a966b28966417721e6bf53c5&language=en-US&page="
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
        getPopularActors()
     }
    
    func getPopularActors(){
        if RequestManager.isConnectedToNetwork(){
            Presentation.showLoading()
            print(pagingNum)
            RequestManager.alamofireRequest(serviceURL: url +  pagingNum, httpMethod: .get, parameters: nil , headers: nil){(responseJSON, isSuccess , isError) in
                Presentation.hideLoading()
                if isSuccess{
                        self.total_pages = responseJSON!["total_pages"] as? Int ?? 0
                        self.actors += (responseJSON!["results"] as? [[String:Any]])!
                        self.actorsCopy += (responseJSON!["results"] as? [[String:Any]])!
                        self.myCollectionViewOutlet.reloadData()
                }else{
                    Presentation.connectionFaildAlert(inView: self)
                }
            }
        }else{
            Presentation.noInternetConnection(self)
        }
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
        return self.actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        (cell.viewWithTag(2) as! UILabel).text = actors[indexPath.row]["name"] as?String ?? ""
        if let img = actors[indexPath.row]["profile_path"] as? String {
                let url = URL(string: (Constants.baseImgUrl  + img))
            let resource = ImageResource(downloadURL: url!, cacheKey: nil)
                (cell.viewWithTag(1) as! UIImageView).kf.setImage(with: resource )
        }else{
            (cell.viewWithTag(1) as! UIImageView).image = #imageLiteral(resourceName: "notfound")
        }
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (actors.count - 1) && !searchActive{
            if Int(pagingNum)! <= total_pages{
                pagingNum = String(Int(pagingNum)! + 1 )
                getPopularActors()
            }
        }else if indexPath.row == 0 && Int(pagingNum) != 1{
            pagingNum = String(Int(pagingNum)! - 1 )
            getPopularActors()
        }
     }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "Details", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2.28, height: UIScreen.main.bounds.width / 2.28)
    }
}

// MARK: my search protocols implimentation
extension PopularActorsVC:UISearchBarDelegate,UISearchDisplayDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchActive = true
        var searchedData = [[String:Any]]()
        searchedData = actorsCopy.filter({ (dictionary) -> Bool in
            return ((dictionary["name"] as! String).lowercased().contains(searchText.lowercased()))
        })
        if searchText.count > 0{
            actors.removeAll()
            actors.append(contentsOf: searchedData)
        }else{
            actors.removeAll()
            actors.append(contentsOf: actorsCopy)
        }
        myCollectionViewOutlet.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.text = ""
        self.searchActive = false
    }
}
