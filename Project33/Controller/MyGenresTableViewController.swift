//
//  MyGenresTableViewController.swift
//  Project33
//
//  Created by Janin Culhaoglu on 30/04/2020.
//  Copyright © 2020 Janin Culhaoglu. All rights reserved.
//

import UIKit

class MyGenresTableViewController: UITableViewController {
    // MARK: - Properties
    var myGenres: [String]!
    let defaults = UserDefaults.standard

    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let savedGenres = defaults.object(forKey: "myGenres") as? [String] {
            myGenres = savedGenres
        } else {
            myGenres = [String]()
        }

        title = "Notify me about..."
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - Methods
    @objc func saveTapped() {
        defaults.set(myGenres, forKey: "myGenres")
    }

    // MARK: - TableView DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SelectGenreTableViewController.genres.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let genre = SelectGenreTableViewController.genres[indexPath.row]
        cell.textLabel?.text = genre

        if myGenres.contains(genre) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }

    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let selectedGenre = SelectGenreTableViewController.genres[indexPath.row]

            if cell.accessoryType == .none{
                cell.accessoryType = .checkmark
                myGenres.append(selectedGenre)
            } else {
                cell.accessoryType = .none
                
                if let index = myGenres.firstIndex(of: selectedGenre) {
                    myGenres.remove(at: index)
                }
            }
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
