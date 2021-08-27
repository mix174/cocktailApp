//
//  DetailsViewController.swift
//  cocktailApp
//
//  Created by Mix174 on 24.08.2021.
//

import UIKit
import SnapKit

protocol DetailsVCProtocol: UIViewController {
    func setValues(item: Item)
    
    func makeInterface()
    func makeConstraints()
    func reload()
}

final class DetailsViewController: UIViewController, DetailsVCProtocol {
    
    var presenter: DetailsPresenterProtocol?
    
    let contentView = UIView()
    
    let mainImage = UIImageView()
    
    let segmentedControl = UISegmentedControl(items: ["Ингридиенты", "Рецепт", "История"])
    
    let addToFavoritesButton = UIButton()
    
    let tableView = UITableView()
    var ingridientsArray: [String] = []
    var howToCockArray: [String] = []
    var historyArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DetailsViewController didLoad")
        presenter?.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setValues(item: Item) {
        mainImage.image = item.image // картинка
        setNaviBar(item: item) // название в navigationBar
        ingridientsArray = item.ingridientsArray
        howToCockArray = item.howToCockArray
        historyArray = item.historyArray
        
        // поменять
        presenter?.setItem(item: item)
    }
    
    func setNaviBar(item: Item) {
        navigationItem.title = item.name
    }
    
    func makeInterface() {
        view.backgroundColor = .white
        
        // Иерархия
        // view as like SafeArea
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        // основная картинка
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainImage)
        
        // сегментед контрол
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(changeSegmentedControlValue), for: .valueChanged)
        segmentedControl.backgroundColor = .purple
        contentView.addSubview(segmentedControl)
        
        // TableView
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 50
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        
        contentView.addSubview(tableView)
        
        // Кнопка "любимые"
        let favoritesButton = UIBarButtonItem(title: "Любимые", style: .plain, target: self, action: #selector(favoritesButtonPressed))
        self.navigationItem.rightBarButtonItem = favoritesButton
        
        // Кнопка "Добавить в любимые"
        addToFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
        addToFavoritesButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        let imagePlus = UIImage(named: "heart-plus")
        addToFavoritesButton.setBackgroundImage(imagePlus, for: .normal)
        contentView.addSubview(addToFavoritesButton)
        contentView.bringSubviewToFront(addToFavoritesButton)
    }
    
    func makeConstraints() {
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(mainImage.snp.width) // сохранение пропорций
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        addToFavoritesButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(mainImage)
            make.height.width.equalTo(60)
        }
    }
    
    // MARK: Навигация
    @objc func favoritesButtonPressed() {
        presenter?.moveToFavorites()
    }
    
    // MARK: Дополнительный функционал
    
    @objc func changeSegmentedControlValue() {
        print("eSegmentedControl Changed Value: \(segmentedControl.selectedSegmentIndex)")
        tableView.reloadData()
    }
    
    @objc func addToFavorites() {
        print("DetailsVC: addToFavorites")
        presenter?.addToFavorites()
    }
    
    func reload() {
        tableView.reloadData()
    }
}


// MARK: Extension для TableView
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentedControl.selectedSegmentIndex {
        case 1:
            return howToCockArray.count
        case 2:
            return historyArray.count
        default:
            return ingridientsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.reuseIdentifier) as! DetailsTableViewCell
        
        let rowItem: String
        switch segmentedControl.selectedSegmentIndex {
        case 1:
            guard let rowData = howToCockArray[safe: indexPath.item] else {
                print("Проблема в данных при построении ячейки в DetailsTableViewCell - howToCockArray")
                return cell
            }
            rowItem = rowData
        case 2:
            guard let rowData = historyArray[safe: indexPath.item] else {
                print("Проблема в данных при построении ячейки в DetailsTableViewCell - historyArray")
                return cell
            }
            rowItem = rowData
        default:
            guard let rowData = ingridientsArray[safe: indexPath.item] else {
                print("Проблема в данных при построении ячейки в DetailsTableViewCell - ingridientsArray")
                return cell
            }
            rowItem = rowData
        }
        cell.setupCell(rowItem: rowItem)
        return cell
    }
}
