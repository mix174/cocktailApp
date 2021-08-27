//
//  MenuAssembly.swift
//  cocktailApp
//
//  Created by Mix174 on 24.08.2021.
//

import UIKit

final class MenuAssembly {
    
//    Метод для создания вьюКонтроллера и соединения с презентером и моделью
    func build() -> MenuVCProtocol {
        let vc = MenuViewController()
        let model = MenuModel()
        let presenter = MenuPresenter(vc: vc, model: model)
        
        vc.presenter = presenter
        presenter.viewController = vc
        return vc
    }
}
