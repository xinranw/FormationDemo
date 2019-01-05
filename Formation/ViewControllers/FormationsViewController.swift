//
//  FormationsViewController.swift
//  Formation
//
//  Created by Xinran on 1/5/19.
//  Copyright © 2019 xinran. All rights reserved.
//

import UIKit
import FontAwesome_swift

final class FormationsViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var backBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "formationCell")
        
//        let attributes = [
//            NSAttributedString.Key.font: UIFont.fontAwesome(ofSize: 16, style: .brands)
//        ]
//        self.backBarButtonItem.
//        self.backBarButtonItem.setTitleTextAttributes(attributes, for: .normal)
//        self.backBarButtonItem.title = String.fontAwesomeIcon(name: .)
    }
    
    @IBAction private func dismissView() {
        self.dismiss(animated: true)
    }
}

extension FormationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
    }
}

extension FormationsViewController: UITableViewDataSource {
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
