//
//  QuestionGroupCell.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 09/04/22.
//

import UIKit
import Combine

public class QuestionGroupCell: UITableViewCell {
    public var percentageSubscriber: AnyCancellable?
    @IBOutlet public var titleLabel: UILabel!
    @IBOutlet public var percentageLabel: UILabel!
}
