//
//  ViewController.swift
//  Project33
//
//  Created by Janin Culhaoglu on 29/04/2020.
//  Copyright © 2020 Janin Culhaoglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "What's that whistle?"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWhistle))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
    }

    @objc func addWhistle() {
        let recordVC = RecordWhistleViewController()
        navigationController?.pushViewController(recordVC, animated: true)
    }
}
