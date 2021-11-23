//
//  ViewController.swift
//  CutTheShape
//
//  Created by L Daniel De San Pedro on 23/11/21.
//

import UIKit

/*
    Explanation
        The ViewController will hold all the outlets and also will register any event
        that occurs on the view. Every event should be repported to the presenter, and
        the presenter will decide what happens. The view controller adapts its content
        according to what the presenter provides.
 */

// MARK: - class - GameViewController
final class GameViewController: UIViewController {
    // MARK: Attributes
    var presenter: GamePresenterProtocol?
    // MARK: Outlets
    @IBOutlet private weak var helloWorldLabel: UILabel?
    
    // MARK: Static methods
    static func instantiateView() -> GameViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "GameViewController", bundle: nil)
        guard let view: GameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else {
            return GameViewController()
        }
        return view
    }
    
    // MARK: View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

// MARK: - extension - GameViewProtocol
extension GameViewController: GameViewProtocol {
    func configureView(with model: GameViewModel) {
        guard let helloWorldLabel: UILabel = helloWorldLabel else { return }
        helloWorldLabel.text = model.helloWorldText
    }
}
