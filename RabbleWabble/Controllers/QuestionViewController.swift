//
//  ViewController.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 07/04/22.
//

import UIKit

public protocol QuestionViewControllerDelegate: AnyObject {
    func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionStrategy)
    
    func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionStrategy)
}

public class QuestionViewController: UIViewController {
    
    //MARK: Instance properties
    public var questionStrategy: QuestionStrategy! {
        didSet {
            navigationItem.title = questionStrategy.title
        }
    }
    public var makeScoreTrackingViewController: ScoreTrackingViewControllerFactory?
    public weak var delegate: QuestionViewControllerDelegate?
    
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "",
                                   style: .plain,
                                   target: nil,
                                   action: nil)
        item.tintColor = .black
        return item
    }()
    
    private lazy var scoreTrackingItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "chart.bar.fill"), style: .plain, target: self, action: #selector(showScoreTrackingViewController))
        return item
    }()
    
    public var questionView: QuestionView! {
        guard isViewLoaded else { return nil }
        return (view as! QuestionView)
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        showQuestion()
        navigationItem.rightBarButtonItems = [scoreTrackingItem, questionIndexItem]
    }

    
    public func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = UIImage(systemName: "list.dash")
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(image: image, landscapeImagePhone: nil, style: .plain, target: self, action: action)
    }
    
    
    @objc private func handleCancelPressed(sender: UIBarButtonItem) {
        delegate?.questionViewController(self, didCancel: questionStrategy)
    }
    

    private func showQuestion() {
        let question = questionStrategy.currentQuestion()
        
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        questionView.answerLabel.text = question.answer
        
        questionView.hintLabel.isHidden = true
        questionView.answerLabel.isHidden = true
        
        questionIndexItem.title = questionStrategy.questionIndexTitle()
    }
    
    
    @IBAction func toggleAnswerLabel(_ sender: Any) {
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
    }
    
    
    @IBAction func handleCorrect(_ sender: Any) {
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionCorrect(question)
        
        questionView.correctCountLabel.text = String(questionStrategy.correctCount)
        showNextQuestion()
    }
    
    
    @IBAction func handleIncorrect(_ sender: Any) {
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionIncorrect(question)
        
        questionView.incorrectCountLabel.text = String(questionStrategy.incorrectCount)
        showNextQuestion()
    }
    
    
    @objc func showScoreTrackingViewController() {
        #warning("handle empty state view")
        show(makeScoreTrackingViewController?.makeScoreTrackingViewController() ?? ScoreTrackingViewController(), sender: self)
    }
    
    
    private func showNextQuestion() {
        guard questionStrategy.advanceToNextQuestion() else {
            delegate?.questionViewController(self, didComplete: questionStrategy)
            return
        }
        showQuestion()
    }
    
}

public protocol ScoreTrackingViewControllerFactory {
    func makeScoreTrackingViewController() -> ScoreTrackingViewController
}
