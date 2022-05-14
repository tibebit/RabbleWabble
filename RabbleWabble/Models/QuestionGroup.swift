//
//  QuestionGroup.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 07/04/22.
//

import Foundation
import Combine

// MARK: - Originator
public class QuestionGroup: Codable {
    
    public class Score: Codable {
        public var correctCount: Int = 0 {
            didSet {
                updateCorrectAnswersPercentage()
            }
        }
        public var incorrectCount: Int = 0 {
            didSet {
                updateCorrectAnswersPercentage()
            }
        }
        public init() { }
        
        private enum CodingKeys: String, CodingKey {
            case correctCount
            case incorrectCount
        }
        
        public required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            correctCount = try container.decode(Int.self, forKey: .correctCount)
            incorrectCount = try container.decode(Int.self, forKey: .incorrectCount)
            updateCorrectAnswersPercentage()
        }
        
        
        func reset() {
            correctCount = 0
            incorrectCount = 0
        }
        
        private func updateCorrectAnswersPercentage() {
            let questionsTotal = incorrectCount + correctCount
            guard questionsTotal > 0 else {
                correctAnswersPercentage = 0
                return
            }
            correctAnswersPercentage = Double(correctCount) / Double(questionsTotal)
        }
        
        @Published public var correctAnswersPercentage: Double = 0
    }
    
    
    public let questions: [Question]
    private(set) var score: Score
    public let title: String
    
    public init(questions: [Question], score: Score = Score(), title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }
}


