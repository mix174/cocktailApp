//
//  FavoritesViewController.swift
//  cocktailApp
//
//  Created by Mix174 on 26.08.2021.
//

import UIKit
import SnapKit

protocol FavoritesVCProtocol: UIViewController {
    func makeInterface()
    func setItems(items: [Item])
    func reload()
}

final class FavoritesViewController: UIViewController, FavoritesVCProtocol {
    
    var presenter: FavoritesPresenterProtocol?
    
    let tableView = UITableView()
    var items: [Item] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("FavoritesViewController: viewWillAppear")
        presenter?.viewWillAppear()
    }
    
    func makeInterface() {
        view.backgroundColor = .white
        setNavBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MenuCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MenuCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 140 // убрать хардкод
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setNavBar() {
        navigationItem.title = "Любимые"
    }
    
    func setItems(items: [Item]) {
        self.items = items
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    // Выбор ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rowItem = items[safe: indexPath.item] else {
            print("Проблема в данных при построении ячейки в MenuViewController")
            return
        }
        presenter?.goToNext(item: rowItem)
    }
    
    // TEST
    deinit {
        print("FavoritesViewController deinit")
    }
}


extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseIdentifier) as! MenuCell
        
        guard let item = items[safe: indexPath.item] else {
            print("Проблемы в данных в FavoritesViewController — dequeueReusableCell")
            return cell
        }
        cell.setup(item: item)
        return cell
    }
}
