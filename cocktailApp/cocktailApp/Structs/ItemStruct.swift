//
//  ItemStruct.swift
//  cocktailApp
//
//  Created by Mix174 on 23.08.2021.
//

import UIKit

struct Item {

    let name: String
//    let tags: [Tags]
    let tag: Tags
    let shortDescrib: String
    let ingridients: String
    let ingridientsArray: [String]
    let howToCock: String
    let howToCockArray: [String]
    let history: String
    let historyArray: [String]
    let image: UIImage?
    
    enum Tags: String {
        case all = "все"
        case classic = "классика"
        case pop = "поп"
//        case nonAlco = "безалкогольный"
        case dry = "сухой"
        case strong = "крепкий"
//        case sweet = "сладкий"
//        case sour = "кислый"
    }
}

extension Item.Tags: CaseIterable { }

extension Item.Tags: RawRepresentable {
    typealias RawValue = String
  
    init?(rawValue: RawValue) {
        switch rawValue {
        case "все":
            self = .all
        case "классика":
            self = .classic
        case "поп":
            self = .pop
//        case "безалкогольный":
//            self = .nonAlco
        case "сухой":
            self = .dry
        case "крепкий":
            self = .strong
//        case "сладкий":
//            self = .sweet
//        case "кислый":
//            self = .sour
        default: return nil
        }
    }
  
    var rawValue: RawValue {
        switch self {
        case .all:
            return "все"
        case .classic:
            return "классика"
        case .pop:
            return "поп"
//        case .nonAlco:
//            return "безалкогольный"
        case .dry:
            return "сухой"
        case .strong:
            return "крепкий"
//        case .sweet:
//            return "сладкий"
//        case .sour:
//            return "кислый"
        }
    }
}
