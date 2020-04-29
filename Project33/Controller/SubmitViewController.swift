//
//  SubmitViewController.swift
//  Project33
//
//  Created by Janin Culhaoglu on 29/04/2020.
//  Copyright © 2020 Janin Culhaoglu. All rights reserved.
//

import UIKit
import CloudKit

class SubmitViewController: UIViewController {
    // MARK: - Properties
    var genre: String!
    var comments: String!

    var stackView: UIStackView!
    var status: UILabel!
    var activityIndicator: UIActivityIndicatorView!

    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "You're all set!"
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        doSubmission()
    }

    // MARK: - Methods
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.gray

        stackView = UIStackView()
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .vertical
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.text = "Submitting..."
        status.textColor = .white
        status.font = UIFont.preferredFont(forTextStyle: .title1)
        status.numberOfLines = 0
        status.textAlignment = .center

        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

        stackView.addArrangedSubview(status)
        stackView.addArrangedSubview(activityIndicator)
    }

    func doSubmission() {
        let whistleRecord = CKRecord(recordType: "Whistles") // this is an object to contain keys and values
        whistleRecord["genre"] = genre as CKRecordValue // like this we convert String to CKRecordValue
        whistleRecord["comments"] = comments as CKRecordValue

        let audioURL = RecordWhistleViewController.getWhistleURL()
        let whistleAsset = CKAsset(fileURL: audioURL) // upload audio to CKAsset before it's attached
        whistleRecord["audio"] = whistleAsset

        CKContainer.default().publicCloudDatabase.save(whistleRecord) { [unowned self] (record, error) in
            DispatchQueue.main.async {
                if error != nil {
                    self.status.text = "Error"
                    self.activityIndicator.stopAnimating()
                } else {
                    self.view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
                    self.status.text = "Done!"
                    self.activityIndicator.stopAnimating()
                    
                    ViewController.isDirty = true
                }
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
            }
        }
    }

    @objc func doneTapped() {
        _ = navigationController?.popToRootViewController(animated: true) // _ is to silence an “unused result”
    }
}
