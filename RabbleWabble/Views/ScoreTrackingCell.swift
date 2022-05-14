//
//  ScoreTrackingCell.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 04/05/22.
//

import UIKit


public final class ScoreTrackingCell: UITableViewCell {
    public static let identifier = String(describing: ScoreTrackingCell.self)
    
    @IBOutlet weak public var correctCount: UILabel!
    @IBOutlet weak public var incorrectCount: UILabel!
    @IBOutlet weak public var completionDate: UILabel!
    @IBOutlet weak public var countsContainerView: UIView!
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        countsContainerView.layer.cornerRadius = 10
        countsContainerView.layer.cornerCurve = .continuous
        countsContainerView.layer.shadowColor = UIColor.black.cgColor
        countsContainerView.layer.shadowOffset = CGSize(width: 0, height: 10)
        countsContainerView.layer.shadowRadius = 20.0
        countsContainerView.layer.shadowOpacity = 0.3
    }
}
