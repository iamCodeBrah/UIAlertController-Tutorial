//
//  ViewController.swift
//  AlertTutorial
//
//  Created by YouTube on 2023-07-16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "3", style: .plain, target: self, action: #selector(didTapThree)),
            UIBarButtonItem(title: "2", style: .plain, target: self, action: #selector(didTapTwo)),
            UIBarButtonItem(title: "1", style: .plain, target: self, action: #selector(didTapOne)),
        ]
    }
    
    @objc private func didTapOne() {
        AlertManager.showNoWifiWarning(on: self)
    }
    
    @objc private func didTapTwo() {
        
        AlertManager.showDeleteConfirmation(on: self) { didDelete in
            if (didDelete == true) {
                print("DELTED")
            } else {
                print("CANCELED")
            }
        }
        
    }
    
    @objc private func didTapThree() {
        AlertManager.signInAlert(on: self) { strings in
            print(strings)
        }
    }
}

