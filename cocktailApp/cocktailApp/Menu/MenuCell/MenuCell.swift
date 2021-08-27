//
//  MenuCell.swift
//  cocktailApp
//
//  Created by Mix174 on 24.08.2021.
//

import UIKit
import SnapKit

final class MenuCell: UITableViewCell {
    // MARK: Аутлеты
    
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var shortDescription: UILabel!
    @IBOutlet private weak var tag1: UILabel!
    @IBOutlet private weak var picture: UIImageView!
    @IBOutlet private weak var arrow: UIImageView!
    
    
    func setup(item: Item) {
        name.text = item.name
        shortDescription.text = item.shortDescrib
        tag1.text = item.tag.rawValue
        
        guard item.image != nil else {
            return
        }
        picture.image = item.image
        makeContraints()
    }
    
    private func makeContraints() {
        picture.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(10)
            make.width.equalTo(picture.snp.height)
        }
        
        arrow.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(5)
            make.width.equalTo(30)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(picture)
            make.leading.equalTo(picture.snp.trailing).offset(20)
            make.trailing.equalTo(arrow.snp.leading)
        }
        
        tag1.snp.makeConstraints { make in
            make.bottom.equalTo(picture)
            make.leading.trailing.equalTo(name)
        }
        
        shortDescription.snp.contentHuggingVerticalPriority = 240
        shortDescription.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(10)
            make.bottom.equalTo(tag1.snp.top).offset(-10)
            make.leading.trailing.equalTo(name)
        }
    }
}
