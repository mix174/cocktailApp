//
//  DetailsPresenter.swift
//  cocktailApp
//
//  Created by Mix174 on 24.08.2021.
//

import UIKit
import CoreData

protocol DetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func setItem(item: Item)
    func addToFavorites()
    func moveToFavorites()
}

final class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var viewController: DetailsVCProtocol?
    private let model: DetailsModelProtocol
    let rootManager = RootManager.shared
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var item: Item?
    
    init(vc: DetailsVCProtocol, model: DetailsModelProtocol) {
        self.viewController = vc
        self.model = model
    }
    
    
    func viewDidLoad() {
        print("DetailsPresenter: viewDidLoad")
        makeInterface()
    }
    
    func makeInterface() {
        viewController?.makeInterface()
        viewController?.makeConstraints()
    }
    
    func moveToFavorites() {
        rootManager.moveToFavorites()
    }
    
    func setItem(item: Item) {
        print("DetailsPresenter: setItem")
        self.item = item
    }
    
    func addToFavorites() {
        print("DetailsPresenter: addToFavorites \(String(describing: item?.name))")
        
        guard let item = item else {return}
        let newName = item.name
        print("newName = \(newName)")
        
        let request = Favorites.fetchRequest() as NSFetchRequest<Favorites>
        let pred = NSPredicate(format: "name CONTAINS '\(newName)'")
        request.predicate = pred
        
        var favorites: [Favorites] = []
        
        do {
            favorites = try context.fetch(request)
            print("Favorites are: \(favorites)")
            print("\(favorites.count)")
            for i in favorites {
                guard let name = i.name else { print("i.name == nil"); return }
                print(name)
            }
        } catch {
            print("Error catched at fetch: \(error)")
        }
        
        guard favorites.isEmpty else {
            print("already exist")
            for i in favorites {
                context.delete(i)
            }
            do {
                try context.save()
            } catch {
                print("error catche while saving: \(error)")
            }
            return
        }
        
        let newFavorite = Favorites(context: context)
        newFavorite.name = newName
        print("saving")
        do {
            try context.save()
        } catch {
            print("error catche while saving: \(error)")
        }
    }
}
