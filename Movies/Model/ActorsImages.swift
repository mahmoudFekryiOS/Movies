//
//  Actors.swift
//  Movies
//
//  Created by mahmoud fekry on 3/28/19.
//  Copyright © 2019 mahmoud fekry. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

struct ActorImages: Mappable {
    var profiles : [Image]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.profiles <- map["profiles"]
     }
}

struct Image: Mappable {
     var filePath: String?
 
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.filePath <- map["file_path"]
    }
}


