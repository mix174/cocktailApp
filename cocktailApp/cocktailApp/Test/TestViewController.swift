//
//  TestViewController.swift
//  cocktailApp
//
//  Created by Mix174 on 23.08.2021.
//

import UIKit
import SnapKit

class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printSmtg()
        let lab = UILabel()
        lab.text = "yo"
        view.addSubview(lab)
        lab.backgroundColor = .red
        lab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(60)
        }
        navigationItem.title = "2"
        navigationItem.rightBarButtonItem?.title = "ji est"
//        navigationItem.leftBarButtonItem?.title = "Back"
        navigationItem.backBarButtonItem?.title = "BackSon"
        
        // Creates the LeftBarButtonItem:
        let backButton = UIBarButtonItem(title: "BackSon", style: .done, target: self, action: #selector(backbuttonPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        
        
        
        print((String(describing: self.navigationController?.description)))
    }
    
    @objc func backbuttonPressed() {
        RootManager.shared.moveBack()
    }
    
    func printSmtg() {
        print("Hello second")
    }
    
    deinit {
        print("Detail deInit")
    }
}
