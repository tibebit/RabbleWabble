//
//  ScoreTrackingViewController.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 03/05/22.
//

import UIKit

public final class ScoreTrackingViewController: UITableViewController {
    public static let storyboardID = String(describing: ScoreTrackingViewController.self)
    public var scores = [QuestionGroup.Score]()
}

//MARK: UITableViewDataSource
extension ScoreTrackingViewController {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTrackingCell.identifier, for: indexPath) as? ScoreTrackingCell else { fatalError() }
        
        cell.correctCount.text = String(describing: scores[indexPath.row].correctCount)
        cell.incorrectCount.text = String(describing: scores[indexPath.row].incorrectCount)
        
        return cell
    }
}
