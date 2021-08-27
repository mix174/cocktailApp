//
//  MenuModel.swift
//  cocktailApp
//
//  Created by Mix174 on 24.08.2021.
//

import UIKit

protocol MenuModelProtocol: AnyObject {
    func genTestData() -> [Item]
}

final class MenuModel: MenuModelProtocol {
    
    func genTestData() -> [Item] {
        var items: [Item] = []
        
        for i in 0...5 {
            var name: String = ""
            var tag: Item.Tags = .pop
            var image: UIImage?
            
            switch i {
            case 0:
                name = "Дайкири"
                image = UIImage(named: "dajkiri-600х600")
                tag = .classic
            case 1:
                name = "Сухой мартини"
                image = UIImage(named: "dryMartini-600х600")
                tag = .dry
            case 2:
                name = "Кайпиринья"
                image = UIImage(named: "kapirinya-600х600")
                tag = .classic
            case 3:
                name = "Мохито"
                image = UIImage(named: "mohito-600х600")
                tag = .pop
            case 4:
                name = "Негрони"
                image = UIImage(named: "negroni-600х600")
                tag = .strong
            case 5:
                name = "Белый русский"
                image = UIImage(named: "whiteRussian-600х600")
                tag = .strong
            default:
                name = "not defined"
                image = UIImage(named: "dryMartini-600х600")
            }
            
            let item = Item(name: name,
                            tag: tag,
                            shortDescrib: "Это краткое описание \(name)",
                            ingridients: """
1) ингридиент
2) ингридиент
3) ингридиент
4) ингридиент
                              
""",
                            ingridientsArray: [
                                "Лед фраппе — 70г",
                                "Лайм — 20 мл",
                                "Мята — 5г",
                                "Тростниковый сахар — 5г",
                                "Кашаса — 45 мл"
                            ],
                            howToCock: """
Здесь написано о том, как правильно приготовить этот коктейль:
1. сделайте первый пункт
2. сделайте второй пункт
3. сделайте третий пункт
4. подайте коктейль
""",
                            howToCockArray: [
                                "Возьмите бокал",
                                "Насыпьте сахар в бокал",
                                "Выдавите лайм",
                                "Размешайте сахар",
                                "Добавьте мяту",
                                "Добавьте лад на 2/3 бокала",
                                "Налейте Кашасу",
                                "Перемешайте содержимое барной ложкой",
                                "Вставьте трубочку, досыпьте лед, украсьте мятой и лаймом",
                                "Готово!"
                            ],
                            history: "Это очень большая и долгая, интересная и местами не очень интересная история знаменитого и очень популярного коктейля \(name). Это очень большая и долгая, интересная и местами не очень интересная история знаменитого и очень популярного коктейля \(name). Это очень большая и долгая, интересная и местами не очень интересная история знаменитого и очень популярного коктейля \(name).",
                            historyArray: [
                                "Это очень большая и долгая, интересная и местами не очень интересная история знаменитого и очень популярного коктейля \(name).",
                                "Это очень большая и долгая, интересная и местами не очень интересная история знаменитого и очень популярного коктейля \(name)."
                            ],
                            image: image)
            items.append(item)
        }
        return items
    }
}
