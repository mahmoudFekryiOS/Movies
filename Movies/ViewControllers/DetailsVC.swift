//
//  DetailsVC.swift
//  Movies
//
//  Created by mahmoud fekry on 3/28/19.
//  Copyright © 2019 mahmoud fekry. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    @IBOutlet weak var myPagerOutlet: UIPageControl!
    @IBOutlet weak var mycollectionOutlet: UICollectionView!
    @IBOutlet weak var birthDayOutlet: UILabel!
    @IBOutlet weak var detailsOutlet: UITextView!

    var actorId = 1
    var actorsImages = [ActorImages]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    func getActorImages(){
       
    }
    
    func getActorDetails(){
        
    }
 
}


extension DetailsVC:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        //(cell.viewWithTag(1) as! UIImageView).image = images[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width  , height: collectionView.frame.height )
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        myPagerOutlet.currentPage = Int(self.mycollectionOutlet.contentOffset.x / self.mycollectionOutlet.frame.size.width)
    }
}
