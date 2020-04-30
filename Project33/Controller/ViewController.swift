//
//  ViewController.swift
//  Project33
//
//  Created by Janin Culhaoglu on 29/04/2020.
//  Copyright © 2020 Janin Culhaoglu. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UITableViewController {
    // MARK: - Properties
    static var isDirty = true
    var whistles = [Whistle]()

    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "What's that whistle?"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWhistle))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true) // Clears the TableView selection if it has one
        }

        if ViewController.isDirty { // We can refresh the data from iCloud here
            loadWhistles()
        }
    }

    // MARK: - Methods
    @objc func addWhistle() {
        let recordVC = RecordWhistleViewController()
        navigationController?.pushViewController(recordVC, animated: true)
    }

    func loadWhistles() {
        
    }

    // To show a text neatly formatted
    func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.purple]
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]

        let titleString = NSMutableAttributedString(string: "\(title)", attributes: titleAttributes)

        if subtitle.count > 0 {
            let subtitleString = NSAttributedString(string: "\n\(subtitle)", attributes: subtitleAttributes)
            titleString.append(subtitleString)
        }
        return titleString
    }
    
    // MARK: - Table View Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return whistles.count
    }

    // We will show the genre and comments in the tableView with formattedString
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.attributedText = makeAttributedString(title: whistles[indexPath.row].genre, subtitle: whistles[indexPath.row].comments)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
