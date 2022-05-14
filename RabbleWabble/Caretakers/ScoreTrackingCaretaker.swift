//
//  ScoreTrackingCaretaker.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 02/05/22.
//

import Foundation

public final class ScoreTrackingCaretaker {
    public var scores = [QuestionGroup.Score]()
    
    public func retrieveScores(for fileName: String) {
        if let scores = try? DiskCaretaker.retrieve([QuestionGroup.Score].self, from: fileName) {
            self.scores = scores
        }
    }
    
    public func save(for fileName: String) throws {
        try DiskCaretaker.save(scores, to: fileName)
    }
}
