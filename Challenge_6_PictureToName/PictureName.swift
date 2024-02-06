//
//  PictureName.swift
//  Challenge_6_PictureToName
//
//  Created by Daniel Freire on 2/6/24.
//

import Foundation

struct PictureName: Comparable, Identifiable {
    let id = UUID()
    var name: String
    var photo: Data
    
    static func < (lhs: PictureName, rhs: PictureName) -> Bool {
        lhs.name < rhs.name
    }
}
