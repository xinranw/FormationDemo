//
//  FormationsListViewController.swift
//  Formation
//
//  Created by Xinran on 1/5/19.
//  Copyright © 2019 xinran. All rights reserved.
//

import UIKit
import FontAwesome_swift

final class FormationsListViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var backBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "formationCell")
    }
    
    @IBAction private func dismissView() {
        self.dismiss(animated: true)
    }
}

extension FormationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
            self.dismissView()
        }
        
        FormationsManager.shared.updateActiveFormation(index: indexPath.row)
    }
}

extension FormationsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FormationsManager.shared.formations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "formationCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = "Formation \(indexPath.row)"
        
        return cell
    }
}
