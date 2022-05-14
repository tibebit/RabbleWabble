//
//  ScoreTrackingCell.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 04/05/22.
//

import UIKit


public final class ScoreTrackingCell: UITableViewCell {
    public static let identifier = String(describing: ScoreTrackingCell.self)

    
    public func configure(with score: QuestionGroup.Score) {
        var configuration = defaultContentConfiguration()
        configuration.image = UIImage(systemName: "checklist")
        configuration.text = "Completed on \(score.completionDate.ddMmYy())"
        configuration.secondaryText = "Incorrect Count: \(score.incorrectCount)\nCorrect Count: \(score.correctCount)"
        contentConfiguration = configuration
    }
}
