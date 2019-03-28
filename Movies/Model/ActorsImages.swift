//
//  Actors.swift
//  Movies
//
//  Created by mahmoud fekry on 3/28/19.
//  Copyright © 2019 mahmoud fekry. All rights reserved.
//

import Foundation
import UIKit

struct ActorImages: Codable {
    let width, height, voteCount: Int
    let voteAverage: Double
    let filePath: String
    let aspectRatio: Double
}
