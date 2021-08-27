//
//  FavoritesPresenter.swift
//  cocktailApp
//
//  Created by Mix174 on 26.08.2021.
//

import UIKit

protocol FavoritesPresenterProtocol: AnyObject {
    func viewWillAppear()
    func goToNext(item: Item)
}

final class FavoritesPresenter: FavoritesPresenterProtocol {
    
    weak var viewController: FavoritesVCProtocol?
    private var model: FavoritesModelProtocol
    private var rootManager = RootManager.shared
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var favorites: [Favorites] = []
    
    init(vc: FavoritesVCProtocol, model: FavoritesModelProtocol) {
        self.viewController = vc
        self.model = model
    }
    
    func viewWillAppear() {
        print("FavoritesPresenter: viewDidLoad")
        fetch()
        configureCocktails()
        viewController?.makeInterface()
        viewController?.reload()
    }
    
    func fetch() {
        print("FavoritesViewController: fetch")
        do {
            favorites = try context.fetch(Favorites.fetchRequest())
            print("Favorites are: \(favorites)")
            print("\(favorites.count)")
            for i in favorites {
                guard let name = i.name else { return }
                print(name)
            }
        } catch {
            print("Error catched at fetch: \(error)")
        }
        
    }
    
    func configureCocktails() {
        let cocktails = rootManager.takeCocktails()
        let favorites = self.favorites
        var items: [Item] = []
        
        for cock in cocktails {
            for favor in favorites {
                if cock.name == favor.name {
                    print("cockName = \(cock.name)")
                    items.append(cock)
                }
            }
        }
        setValuesOnView(items: items)
//        print("configureCocktails(): \(items)")
    }
    
    func setValuesOnView(items: [Item]) {
        viewController?.setItems(items: items)
    }
    
    func goToNext(item: Item) {
        rootManager.moveToDetails(item: item)
    }
}
