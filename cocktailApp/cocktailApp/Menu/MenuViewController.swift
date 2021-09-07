//
//  MenuViewController.swift
//  cocktailApp
//
//  Created by Mix174 on 22.08.2021.
//

import UIKit
import SnapKit

protocol MenuVCProtocol: UIViewController {
    func makeInterface()
    func makeConstraints()
    func setData(items: [Item])
    func reload()
}

final class MenuViewController: UIViewController, MenuVCProtocol {
    // MARK: Связи
    var presenter: MenuPresenterProtocol?
    
    // MARK: Элементы
    // Таблица
    let tableView = UITableView()
    // Полный список коктейлей
    var items: [Item] = []
    // Фильтрованный список коктейлей
    var itemsFiltered: [Item] = []
    // Контроллер поиска
    let searchController = UISearchController(searchResultsController: nil)
    // Футер с количеством найденных коктейлей
    let resultFooter = ResultFooter()
    // Нижний констрейнт футера
    private var resultFooterBottom = 0
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MenuViewController didLoad")
        presenter?.viewDidLoad()
        setNotificationCenter()
    }
    // MARK: Настройка интерфейса
    func makeInterface() {
        
        view.backgroundColor = .white
        
        tableView.register(UINib(nibName: MenuCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MenuCell.reuseIdentifier)
        
        // Delegate
        tableViewDelegate()
        searchControllerSetup()
        
        tableView.rowHeight = 140 // убрать хардкод
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        
        view.addSubview(resultFooter)
        view.bringSubviewToFront(resultFooter)
        
        
        let favoritesButton = UIBarButtonItem(title: "Любимые", style: .plain, target: self, action: #selector(favoritesButtonPressed))
        self.navigationItem.rightBarButtonItem = favoritesButton
        
        setNaviBar()
    }
    
    func tableViewDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    
    func setNaviBar() {
        navigationItem.title = "Cocktails&Dreams"
        navigationItem.backButtonTitle = "Назад"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .darkPurple
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        resultFooter.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50) // Хардкод
        }
    }
    // MARK: Функции данных
    // Установка данных о коктейлях
    func setData(items: [Item]) {
        self.items = items
    }
    
    // Обновление данных
    func reload() {
        tableView.reloadData()
    }
    
    // MARK: Навигация
    // Переход на вторую страницу
    func goToNext(item: Item) {
        presenter?.moveToDetails(item: item)
    }
    
    @objc func favoritesButtonPressed() {
        presenter?.moveToFavorites()
    }
    
    // MARK: Настройка поиска
    func searchControllerSetup() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        let searchBar = searchController.searchBar
        searchBar.placeholder = "Найти тот самый"
        searchBar.setValue("Отмена", forKey: "cancelButtonText")
        searchBar.scopeButtonTitles = Item.Tags.allCases.map {
            $0.rawValue
        }
        searchBar.delegate = self
    }
    
    // MARK: Настройка футера с количеством
    // Настройка NotificationCenter для футера с результатами
    func setNotificationCenter() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil, queue: .main) { (notification) in
                                        self.handleKeyboard(notification: notification) }
        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                       object: nil, queue: .main) { (notification) in
                                        self.handleKeyboard(notification: notification) }
    }
    
    // изменение констрейнтов футера из-за появления/скрытия клавиатуры
    func handleKeyboard(notification: Notification) {
      // 1
        guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
            // переделать
            resultFooter.snp.remakeConstraints { make in
                make.bottom.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(50) // Хардкод
            }
//            view.layoutIfNeeded()
            return
        }
        guard
            let info = notification.userInfo,
            let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return
        }

      // 2
        let keyboardHeight = keyboardFrame.cgRectValue.size.height
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            // переделать
            self.resultFooter.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(keyboardHeight)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(50) // Хардкод
            }
//            self.view.layoutIfNeeded()
        })
    }
}


extension MenuViewController {
    // Сброс прошлого выбора
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // Условия для строки поиска
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    // Условия для строки поиска
    var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    // Функция фильтрации
    // нужно добавить возможность иметь множество хештэгов на одном Item
    func filterContentForSearchText(_ searchText: String,
                                    tag: Item.Tags? = nil) {
        itemsFiltered = items.filter { (item: Item) -> Bool in
            let doesTagMatch = (tag == .all) || (item.tag == tag)
        
            if isSearchBarEmpty {
                return doesTagMatch
            } else {
                return doesTagMatch && item.name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering {
        resultFooter.setIsFilteringToShow(filteredItemCount: itemsFiltered.count, of: items.count) // Триггер к оценке поиска (показать)
        return itemsFiltered.count
    }
        resultFooter.setNotFiltering() // Триггер к оценке поиска (скрыть)
        return items.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseIdentifier, for: indexPath) as! MenuCell
        
        var itemData: Item
        if isFiltering {
            guard let rowItem = itemsFiltered[safe: indexPath.item] else {
                print("Проблема в данных при построении ячейки в MenuViewController")
                return cell
            }
            itemData = rowItem
        } else {
            guard let rowItem = items[safe: indexPath.item] else {
                print("Проблема в данных при построении ячейки в MenuViewController")
                return cell
            }
            itemData = rowItem
        }
        cell.setup(item: itemData)
        return cell
    }
    
    // Выбор ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            guard let rowItem = itemsFiltered[safe: indexPath.item] else {
                print("Проблема в данных при построении ячейки в MenuViewController")
                return
            }
            goToNext(item: rowItem)
        } else {
            guard let rowItem = items[safe: indexPath.item] else {
                print("Проблема в данных при построении ячейки в MenuViewController")
                return
            }
            goToNext(item: rowItem)
        }
    }
}

extension MenuViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let tag = Item.Tags(rawValue: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        filterContentForSearchText(searchBar.text!, tag: tag)
    }
}

extension MenuViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let tag = Item.Tags(rawValue: searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!, tag: tag)
    }
}
