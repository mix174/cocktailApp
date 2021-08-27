//
//  RootManager.swift
//  cocktailApp
//
//  Created by Mix174 on 23.08.2021.
//

import UIKit

final class RootManager {
    // MARK: Singleton
    static let shared = RootManager()
    // MARK: Хранение контроллеров
    private weak var navigationController: UINavigationController?
    private weak var menuViewController: MenuVCProtocol?
    private weak var detailViewController: DetailsVCProtocol?
    private weak var favoritesViewController: FavoritesVCProtocol?
    
    private var cocktails: [Item] = [] // временно
    
    // MARK: Функция Старта
    func start(window: UIWindow) {
        
        let module = MenuAssembly()
        let menuViewController = module.build()
        self.menuViewController = menuViewController
        let navigationController = UINavigationController(rootViewController: menuViewController)
        self.navigationController = navigationController
        window.rootViewController = navigationController
    }
    
    // MARK: Функции навигации
    // К детальной странице
    func moveToDetails(item: Item) {
        
        let module = DetailsAssembly()
        let detailViewController = module.build()
        // Передача данных в DetailViewController
        detailViewController.setValues(item: item)
        
        self.detailViewController = detailViewController
        navigationController?.pushViewController(detailViewController, animated: true)
        print("RootManager: Detail pushed")
    }
    
    // К странице с любимыми
    func moveToFavorites() {
        print("moveToFavorites: unavailable")
        let module = FavoritesAssembly()
        let favoritesViewController = module.build()
        
        self.favoritesViewController = favoritesViewController
        navigationController?.pushViewController(favoritesViewController, animated: true)
    }
    
    // Назад
    func moveBack() {
        navigationController?.popViewController(animated: true)
    }
    
    
    // Временно
    func setCocktails(items: [Item]) {
        self.cocktails = items
    }
    func takeCocktails() -> [Item] {
        self.cocktails
    }
}
