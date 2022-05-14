//
//  AppSettingsViewController.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 14/04/22.
//

import UIKit

class AppSettingsViewController: UITableViewController {
    
    //MARK: - Properties
    public let appSettings = AppSettings.shared
    public let cellIdentifier = "basicCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

//MARK: - UITableViewDataSource
extension AppSettingsViewController {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionStrategyType.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]
        
        cell.textLabel?.text = questionStrategyType.title()
        
        if appSettings.questionStrategyType == questionStrategyType {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension AppSettingsViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]
        appSettings.questionStrategyType = questionStrategyType
        tableView.reloadData()
    }
}
