//
//  UIColor+extensions.swift
//  cocktailApp
//
//  Created by Mix174 on 27.08.2021.
//

import UIKit

extension UIColor {
    class var darkPurple: UIColor {
        guard let darkPurple = UIColor(named: "DarkPurple") else {
            print("Color named \"DarkPurple\" not found in Assets. Purple color returned instead")
            return .purple
        }
        return darkPurple
    }
}
