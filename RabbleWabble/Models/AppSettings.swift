//
//  AppSettings.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 14/04/22.
//

import Foundation

public class AppSettings {
    //MARK: - Static Properties
    public static let shared = AppSettings()
    
    
    //MARK: - Instance Properties
    private let userDefaults = UserDefaults.standard
    public var questionStrategyType: QuestionStrategyType {
        get {
            let rawValue = userDefaults.integer(forKey: Keys.questionStrategy)
            return QuestionStrategyType(rawValue: rawValue)!
        } set {
            userDefaults.set(newValue.rawValue, forKey: Keys.questionStrategy)
        }
    }
    
    
    //MARK: - Object Lifecycle
    private init() { }
    
    
    //MARK: - Instance Methods
    public func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy {
        questionStrategyType.questionStrategy(for: questionGroupCaretaker)
    }
    
    
    //MARK: - Keys
    private struct Keys {
        static let questionStrategy = "questionStrategy"
    }
}

public enum QuestionStrategyType: Int, CaseIterable {
    case sequential
    case random
    
    //MARK: - Instance Methods
    public func title() -> String {
        switch self {
        case .sequential:
            return "Sequential"
        case .random:
            return "Random"
        }
    }
    
    public func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy {
        switch self {
        case .sequential:
            return SequentialQuestionStrategy(questionGroupCaretaker: questionGroupCaretaker)
        case .random:
            return RandomQuestionStrategy(questionGroupCaretaker: questionGroupCaretaker)
        }
    }
}
