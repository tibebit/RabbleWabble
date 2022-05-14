//
//  RandomQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 13/04/22.
//

import GameplayKit.GKRandomSource

class RandomQuestionStrategy: BaseQuestionStrategy {
    
    //MARK: - Object Lifecycle
    public convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let randomSource = GKRandomSource.sharedRandom()
        let questions = randomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
}
