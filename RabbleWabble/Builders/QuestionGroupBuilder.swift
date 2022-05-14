//
//  QuestionGroupBuilder.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 22/04/22.
//

public class QuestionBuilder {
    public var answer = ""
    public var hint = ""
    public var prompt = ""
    
    public func build() throws -> Question {
        guard answer.count > 0 else { throw Error.missingAnswer}
        guard prompt.count > 0 else { throw Error.missingPrompt}
        return Question(answer: answer, hint: hint, prompt: prompt)
    }
    
    public enum Error: String, Swift.Error {
        case missingAnswer, missingPrompt
    }
}

public class QuestionGroupBuilder {
    
    public var questions = [QuestionBuilder]()
    public var title = ""
    
    
    public func addNewQuestion() {
        let question = QuestionBuilder()
        questions.append(question)
    }
    
    
    public func removeQuestion(at index: Int) {
        questions.remove(at: index)
    }
    
    
    public func build() throws -> QuestionGroup {
        guard self.title.count > 0 else { throw Error.missingTitle}
        guard self.questions.count > 0 else { throw Error.missingQuestions}
        
        let questions = try self.questions.map { try $0.build() }
        return QuestionGroup(questions: questions, title: title)
    }
    
    
    public enum Error: String, Swift.Error {
        case missingQuestions, missingTitle
    }
}
