//
//  File.swift
//  Movies
//
//  Created by mahmoud fekry on 3/28/19.
//  Copyright © 2019 mahmoud fekry. All rights reserved.
//

import Foundation
import RappleProgressHUD
struct Constants {
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let baseImgUrl = "https://image.tmdb.org/t/p/w600_and_h900_bestv2"
    

}

struct Presentation {
    // show loading
    static func showLoading() {
        let title = "Loading..."
        let attributes = RappleActivityIndicatorView.attribute(style: RappleStyle(rawValue: RappleStyleCircle)!, tintColor: .white, screenBG: .black, progressBG: .black, progressBarBG: .lightGray, progreeBarFill: .yellow, thickness: 2.0)
        RappleActivityIndicatorView.startAnimatingWithLabel(title, attributes: attributes)
    }
    
    //hide loading
    static func hideLoading() {
        RappleActivityIndicatorView.stopAnimation()
    }
    
    
    static func noInternetConnection(_ inView: UIViewController) {
        let alert = UIAlertController(title: "ًWrong", message:  "No internet access", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        inView.present(alert, animated: true, completion: nil)
    }
    
    static func connectionFaildAlert(inView: UIViewController) {
        let alert = UIAlertController(title: "alertTitle", message:"ErrorInApi", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK" , style: .default, handler: nil))
        inView.present(alert, animated: true, completion: nil)
    }

}


