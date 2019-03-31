//
//  DetailsVC.swift
//  Movies
//
//  Created by mahmoud fekry on 3/28/19.
//  Copyright © 2019 mahmoud fekry. All rights reserved.
//

import UIKit
import ObjectMapper
import Kingfisher

class DetailsVC: UIViewController {
    @IBOutlet weak var myPagerOutlet: UIPageControl!
    @IBOutlet weak var mycollectionOutlet: UICollectionView! // image slider
    @IBOutlet weak var birthDayOutlet: UILabel!
    @IBOutlet weak var detailsOutlet: UITextView!
    
    var actorId = 2231
    var actorNamre = ""
    var actorsImages:ActorImages?
    var paging = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.actorNamre
        getActorDetails()
    }
    
    
    func getActorImages(){
        RequestManager.alamofireRequestJson(serviceURL: "person/\(actorId)/images?api_key=10bcaef3a966b28966417721e6bf53c5") { (json, success) in
            Presentation.hideLoading()
            if success{
                let jsonDict = json as! [String:Any]
                self.actorsImages = Mapper<ActorImages>().map(JSON: jsonDict)
                self.myPagerOutlet.numberOfPages = (self.actorsImages?.profiles?.count)!
                self.myPagerOutlet.currentPage = 0
                self.mycollectionOutlet.reloadData()
                self.swipeImages()
            }
        }
    }
    
    func getActorDetails(){
        if RequestManager.isConnectedToNetwork(){
            Presentation.showLoading()
            RequestManager.alamofireRequest(serviceURL: "person/\(actorId)?api_key=10bcaef3a966b28966417721e6bf53c5&language=en-US", httpMethod: .get, parameters: nil , headers: nil){(responseJSON, isSuccess , isError) in
                self.getActorImages()
                if isSuccess{
                    self.detailsOutlet.text = responseJSON!["biography"] as? String ?? ""
                    self.birthDayOutlet.text = responseJSON!["birthday"] as? String ?? ""
                }else{
                    Presentation.connectionFaildAlert(inView: self)
                }
            }
        }else{
            Presentation.noInternetConnection(self)
        }
    }
    
    func swipeImages(){
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
            self.paging += 1
            if self.paging < (self.actorsImages?.profiles?.count)!{
                self.mycollectionOutlet.scrollToItem(at:IndexPath(item: self.paging, section: 0) , at: .right, animated: true)
                self.myPagerOutlet.currentPage = self.paging
            }else{
                self.paging = 0
                self.mycollectionOutlet.scrollToItem(at:IndexPath(item: self.paging, section: 0) , at: .right, animated: true)
                self.myPagerOutlet.currentPage = self.paging
            }
        }
    }
}


extension DetailsVC:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.actorsImages?.profiles != nil{
            return (self.actorsImages?.profiles?.count)!
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        if let img = self.actorsImages?.profiles?[indexPath.row].filePath{
            let url = URL(string: Constants.baseImgUrl + img)
            let resource = ImageResource(downloadURL: url!, cacheKey: nil)
            (cell.viewWithTag(1) as! UIImageView).kf.setImage(with: resource)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width  , height: collectionView.frame.height )
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        myPagerOutlet.currentPage = Int(self.mycollectionOutlet.contentOffset.x / self.mycollectionOutlet.frame.size.width)
        paging = myPagerOutlet.currentPage
        
    }
    
}
