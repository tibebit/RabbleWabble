//
//  SelectQuestionGroupViewController.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 09/04/22.
//

import UIKit
import Combine

public class SelectQuestionGroupViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    //MARK: - Properties
    private let questionGroupCaretaker = QuestionGroupCaretaker()
    private let scoreTrackingCaretaker = ScoreTrackingCaretaker()
    private var selectedQuestionGroup: QuestionGroup! {
        get { return questionGroupCaretaker.selectedQuestionGroup}
        set { questionGroupCaretaker.selectedQuestionGroup = newValue}
    }
    private let appSettings = AppSettings.shared
}


extension SelectQuestionGroupViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questionGroupCaretaker.questionGroups.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell", for: indexPath) as? QuestionGroupCell else { fatalError() }
        
        let questionGroup = questionGroupCaretaker.questionGroups[indexPath.row]
        cell.titleLabel.text = questionGroup.title
        cell.percentageSubscriber = questionGroup.score.$correctAnswersPercentage
            .receive(on: DispatchQueue.main)
            .map {
                String(format: "%.0f %%", round(100 * $0))
            }.assign(to: \.text, on: cell.percentageLabel)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SelectQuestionGroupViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionGroupCaretaker.questionGroups[indexPath.row]
        scoreTrackingCaretaker.retrieveScores(for: selectedQuestionGroup.title)
        return indexPath
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            guard let self = self else { return }
            
            self.questionGroupCaretaker.delete(at: indexPath.row)
            DispatchQueue.main.async {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] action, view, success in
            self?.performSegue(withIdentifier: "EditQuestionGroup", sender: indexPath)
        }
        editAction.backgroundColor = .systemYellow
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? QuestionViewController {
            viewController.questionStrategy = appSettings.questionStrategy(for: questionGroupCaretaker)
            viewController.makeScoreTrackingViewController = self
            viewController.delegate = self
        } else if let navController = segue.destination as? UINavigationController, let viewController = navController.topViewController as? CreateQuestionGroupViewController {
            viewController.delegate = self
            if segue.identifier == "EditQuestionGroup" {
                guard let indexPath = sender as? IndexPath else { return }
                viewController.questionGroupBuilder.title = questionGroupCaretaker.questionGroups[indexPath.row].title
                viewController.questionGroupBuilder.questions = questionGroupCaretaker.questionGroups[indexPath.row].questions.map({
                    let questionBuilder = QuestionBuilder()
                    questionBuilder.prompt = $0.prompt
                    questionBuilder.hint = $0.hint ?? ""
                    questionBuilder.answer = $0.answer
                    return questionBuilder
                })
                print("Hello")
            }
        }
    }
}

//MARK: - QuestionViewControllerDelegate
extension SelectQuestionGroupViewController: QuestionViewControllerDelegate {
    public func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionStrategy) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    public func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionStrategy) {
        scoreTrackingCaretaker.scores.append(questionGroup.computeFinalScore())
        try? scoreTrackingCaretaker.save(for: questionGroup.title)
        navigationController?.popToViewController(self, animated: true)
    }
}


//MARK: - CreateQuestionGroupViewControllerDelegate
extension SelectQuestionGroupViewController: CreateQuestionGroupViewControllerDelegate {
    
    public func createQuestionGroupViewControllerDidCancel(_ viewController: CreateQuestionGroupViewController) {
        dismiss(animated: true)
    }
    
    public func createQuestionGroupViewController(_ viewController: CreateQuestionGroupViewController, created questionGroup: QuestionGroup) {
        questionGroupCaretaker.questionGroups.append(questionGroup)
        try? questionGroupCaretaker.save()
        
        dismiss(animated: true)
        tableView.reloadData()
    }
}

extension SelectQuestionGroupViewController: ScoreTrackingViewControllerFactory {
    
    public func makeScoreTrackingViewController() -> ScoreTrackingViewController {
        #warning("handle empty state view")
        guard let scoreTrackingViewController = storyboard?.instantiateViewController(withIdentifier: ScoreTrackingViewController.storyboardID) as? ScoreTrackingViewController else { return ScoreTrackingViewController()}
        scoreTrackingViewController.scores = scoreTrackingCaretaker.scores
        return scoreTrackingViewController
    }
}
