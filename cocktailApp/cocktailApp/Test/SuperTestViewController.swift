//
//  SuperTestViewController.swift
//  cocktailApp
//
//  Created by Mix174 on 23.08.2021.
//

import UIKit
import SnapKit

class SuperTestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello first")
        view.backgroundColor = .white
        if #available(iOS 14.0, *) {
            let button = UIButton(type: .roundedRect, primaryAction: UIAction(
                                    handler: { [weak self] _ in
                                        guard let self = self else {return}
                                        self.goToNext()
            }))
            button.backgroundColor = .blue
            button.titleLabel?.text = "forvard"
            view.addSubview(button)
            button.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
            
        } else {
            print("button is not available")
        }
    }
    

    @IBAction func next(_ sender: UIButton) {
        print("go to next")
        goToNext()
    }
    func goToNext() {
        print("go to next")
//        let secondVC = TestViewController()
//        self.present(secondVC, animated: true, completion: nil)
//        self.show(secondVC, sender: nil)
//        self.showDetailViewController(secondVC, sender: nil)
//        self.navigationController?.pushViewController(secondVC, animated: true)
//        RootManager.shared.moveToDetails()
    }
}
