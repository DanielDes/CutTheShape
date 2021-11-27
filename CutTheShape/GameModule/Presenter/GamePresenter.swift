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
    var gameModel: GameModel?
    
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
        interactor?.obtainConfiguration(canvaBound: canvaBound)
    }
    
    func shouldStartGame() {
        interactor?.startGame()
    }
    
    func shouldFinishGame() {
        interactor?.finishGame()
    }
}

// MARK: - extension - GamePresenterInteractorOutputProtocol
extension GamePresenter: GameInteractorOutputProtocol {
    func configureView(with model: GameViewModel) {
        view?.configureView(with: model)
    }

    func configureGame(with model: GameModel) {
        gameModel = model
        view?.configureGame(with: model)
    }
    
    func shouldUpdateTimer(time: String) {
        view?.updateTimer(time: time)
    }
    func timeDidEnded() {
        view?.restartView()
    }
}

extension GamePresenter: GameCanvaDelegate {
    func didDraw(toPoint point: CGPoint) {
        guard let gameModel: GameModel = gameModel else {
            return
        }
        print("Point is inside of innerShape:  \(gameModel.shape.innerBezierpath.contains(point))")
        print("Point is inside of outerShape:  \(gameModel.shape.outerShapePath.contains(point))")
        print("Point is inside of backgroundShape:  \(gameModel.brackGroundShapePath.contains(point))")
    }

    func shouldDraw(fromPoint point: CGPoint) -> Bool {
        guard let gameModel: GameModel = gameModel else { return false }
        return gameModel.brackGroundShapePath.contains(point)
    }
}
