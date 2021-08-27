//
//  DetailsAssembly.swift
//  cocktailApp
//
//  Created by Mix174 on 24.08.2021.
//

import UIKit

final class DetailsAssembly {
    
//    Метод для создания вьюКонтроллера и соединения с презентером и моделью
    func build() -> DetailsVCProtocol {
        let vc = DetailsViewController()
        let model = DetailsModel()
        let presenter = DetailsPresenter(vc: vc, model: model)
        
        vc.presenter = presenter
        return vc
    }
}
