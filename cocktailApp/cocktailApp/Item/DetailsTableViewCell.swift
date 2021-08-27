//
//  DetailsTableViewCell.swift
//  cocktailApp
//
//  Created by Mix174 on 26.08.2021.
//

import UIKit
import SnapKit

final class DetailsTableViewCell: UITableViewCell {
    private let valueLabel = UILabel()
    
    func setupCell(rowItem: String) {
        setValues(rowItem: rowItem)
        setApperance()
        makeConstraints()
    }
    
    private func setValues(rowItem: String) {
        valueLabel.text = rowItem
        
    }
    
    private func setApperance() {
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.numberOfLines = 0
        valueLabel.sizeToFit()
        valueLabel.font = valueLabel.font.withSize(25)
        
        contentView.addSubview(valueLabel)
    }
    
    private func makeConstraints() {
        valueLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
}
