//
//  FavoritesAssembly.swift
//  cocktailApp
//
//  Created by Mix174 on 26.08.2021.
//

import UIKit

final class FavoritesAssembly {
    
//    Метод для создания вьюКонтроллера и соединения с презентером и моделью
    func build() -> FavoritesVCProtocol {
        let vc = FavoritesViewController()
        let model = FavoritesModel()
        let presenter = FavoritesPresenter(vc: vc, model: model)
        
        vc.presenter = presenter    
        return vc
    }
}
