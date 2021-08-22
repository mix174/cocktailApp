//
//  ItemStruct.swift
//  cocktailApp
//
//  Created by Mix174 on 23.08.2021.
//

import UIKit

enum Category {
    case classic
    case pop
    case nonAlco
}

struct Item {

    let name: String
    let category: Category
    let shortDescrib: String
    let longDescrib: String
    let ingridients: String
    
}
