//
//  SequentialQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 13/04/22.
//

import Foundation

public class SequentialQuestionStrategy: BaseQuestionStrategy {
    public convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let questions = questionGroup.questions
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
}
