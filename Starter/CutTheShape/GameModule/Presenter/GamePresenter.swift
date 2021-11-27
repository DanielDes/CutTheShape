//
//  GamePresenter.swift
//  CutTheShape
//
//  Created by L Daniel De San Pedro on 23/11/21.
//

import Foundation
import UIKit

/*
    Explanation
        The presenter is the one who decides what happens inside the
        module.
        The presenter ask the interactor for game rules and conditions
        (business logic) and the presenter coordinates. The presenter
        could tell the router to go to a module or even to dismiss the
        module. The presenter tells the view what to show or hide and how.
 */


// MARK: - class - GamePresenter
final class GamePresenter: GamePresenterProtocol {
    // MARK: Atributes
    var interactor: GameInteractorProtocol?
    var router: GameRouterProtocol?
    weak var view: GameViewProtocol?

    
    // MARK: Init
    init(view: GameViewProtocol, interactor: GameInteractorProtocol, router: GameRouterProtocol) {
        interactor.presenter = self
        view.presenter = self
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Methods
    func viewDidLoad(canvaBound: CGRect) {

    }
    
    func shouldStartGame() {

    }
    
    func shouldFinishGame() {

    }

    func didTapConfig() {

    }
}

// MARK: - extension - GamePresenterInteractorOutputProtocol
extension GamePresenter: GameInteractorOutputProtocol {
    func configureView(with model: GameViewModel) {

    }

    func configureGame(with model: GameModel) {

    }
    
    func shouldUpdateTimer(time: String) {

    }

    func playerDidWin() {

    }

    func playerDidLose() {

    }

    private func restartGameState() {

    }
}

extension GamePresenter: GameCanvaDelegate {
    func didDraw(toPoint point: CGPoint) {

    }

    func shouldDraw(fromPoint point: CGPoint) -> Bool {
        return true
    }
}

struct HashablePoint: Hashable {
    var x: CGFloat
    var y: CGFloat
}

extension HashablePoint {
    init(point: CGPoint) {
        self.x = point.x
        self.y = point.y
    }
}
