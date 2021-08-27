//
//  UITableViewCell+extensions.swift
//  cocktailApp
//
//  Created by Mix174 on 24.08.2021.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
