//
//  AddCommentsViewController.swift
//  Project33
//
//  Created by Janin Culhaoglu on 29/04/2020.
//  Copyright © 2020 Janin Culhaoglu. All rights reserved.
//

import UIKit

class AddCommentsViewController: UIViewController {
    // MARK: - Properties
    var genre: String!
    var comments: UITextView!
    let placeholder = "If you have any additional comments that might help identify your tune, enter them here."

    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Comments"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitTapped))
        comments.text = placeholder
    }

    // MARK: - Methods
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        comments = UITextView()
        comments.translatesAutoresizingMaskIntoConstraints = false
        comments.delegate = self
        comments.font = UIFont.preferredFont(forTextStyle: .body)
        view.addSubview(comments)

        NSLayoutConstraint.activate([
            comments.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            comments.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            comments.topAnchor.constraint(equalTo: view.topAnchor),
            comments.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func submitTapped() {
        let vc = SubmitViewController()
        vc.genre = genre

        if comments.text == placeholder {
            vc.comments = ""
        } else {
            vc.comments = comments.text
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AddCommentsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
        }
    }
}
