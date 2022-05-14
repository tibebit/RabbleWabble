//
//  RabbleWabbleTests.swift
//  RabbleWabbleTests
//
//  Created by Fabio Tiberio on 07/04/22.
//

import XCTest
import Combine
@testable import RabbleWabble

class RabbleWabbleTests: XCTestCase {
    var subscriptions = [AnyCancellable]()

    func test_QuestionGroup_CorrectAnswersPercentageIsZero() {
        //given
        let questions = [Question(answer: "", hint: "", prompt: ""), Question(answer: "", hint: "", prompt: "")]
        let sut = QuestionGroup(questions: questions, title: "Test")
        //when
        sut.score.incorrectCount += 1
        //then
        XCTAssertEqual(0.0, sut.score.correctAnswersPercentage)
    }

}
