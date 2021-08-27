//
//  ResultFooter.swift
//  cocktailApp
//
//  Created by Mix174 on 25.08.2021.
//

import UIKit

final class ResultFooter: UIView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
      
        configureView()
    }
    
    override func draw(_ rect: CGRect) {
        label.frame = bounds
    }
    
    func setNotFiltering() {
        label.text = ""
        hideFooter()
    }
    
    func setIsFilteringToShow(filteredItemCount: Int, of totalItemCount: Int) {
        if (filteredItemCount == totalItemCount) {
            setNotFiltering()
        }   else if (filteredItemCount == 0) {
            label.text = "Ничего не найдено:("
            showFooter()
        } else {
            label.text = "Найдено коктейлей: \(filteredItemCount)"
            showFooter()
        }
    }
    
    func hideFooter() {
        UIView.animate(withDuration: 0.7) {
            self.alpha = 0.0
        }
    }
    
    func showFooter() {
        UIView.animate(withDuration: 0.7) {
            self.alpha = 1.0
        }
    }
    
    func configureView() {
        backgroundColor = UIColor.purple
        alpha = 0.0
        label.textAlignment = .center
        label.textColor = UIColor.white
        addSubview(label)
    }
}
