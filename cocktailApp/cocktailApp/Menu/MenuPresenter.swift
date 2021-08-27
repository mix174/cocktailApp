//
//  MenuPresenter.swift
//  cocktailApp
//
//  Created by Mix174 on 24.08.2021.
//

import UIKit

protocol MenuPresenterProtocol: AnyObject {
    func viewDidLoad()
    
    func moveToDetails(item: Item)
    func moveToFavorites()
}

final class MenuPresenter: MenuPresenterProtocol {
    // MARK: Связи
    weak var viewController: MenuVCProtocol?
    private let model: MenuModelProtocol
    let rootManager = RootManager.shared
    
    init(vc: MenuVCProtocol, model: MenuModelProtocol) {
        self.viewController = vc
        self.model = model
    }
    
    func viewDidLoad() {
        print("MenuPresenter: viewDidLoad")
        takeData()
        makeInterface()
        viewController?.reload()
    }
    func takeData() {
        let data = model.genTestData()
        viewController?.setData(items: data)
        rootManager.setCocktails(items: data) // временно
    }
    func makeInterface() {
        viewController?.makeInterface()
        viewController?.makeConstraints()
    }
    
    func moveToDetails(item: Item) {
        rootManager.moveToDetails(item: item)
    }
    func moveToFavorites() {
        rootManager.moveToFavorites()
    }
    
}
