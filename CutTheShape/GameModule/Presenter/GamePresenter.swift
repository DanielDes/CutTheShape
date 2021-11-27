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
    private var pointResultsCaptured: [HashablePoint: Bool] = [HashablePoint : Bool]()
    
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
        view?.updateButton(withState: .finish)
        view?.enableInteraction(true)
        view?.enableConfigButton(false)
    }
    
    func shouldFinishGame() {
        view?.updateButton(withState: .start)
        view?.enableInteraction(false)
        view?.enableConfigButton(true)
        let trueValues: [Bool] = pointResultsCaptured.values.filter { Value in
            return Value
        }
        interactor?.finishGame(withScore: trueValues.count)
    }

    func didTapConfig() {
        guard let availableDificulties: [String] = interactor?.obtainGameDificulties(),
        let view: UIViewController = view else { return }
        router?.displayAlertSheet(title: "Dificulty Options", message: "Choose a dificulty", actionSheetTitles: availableDificulties, handler: { [weak self] action in
            guard let self: GamePresenter = self,
                  let title: String = action.title,
                  let dificultyIndex: Int = availableDificulties.firstIndex(of: title) else { return }
            self.view?.restartView()
            self.interactor?.changeDificulty(dificultyIndex: dificultyIndex)
        }, from: view)
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

    func playerDidWin() {
        restartGameState()
        guard let view: UIViewController = view else { return }
        router?.displayAlert(title: "You survived!", message: "You get to live another day!", from: view)
    }

    func playerDidLose() {
        restartGameState()
        guard let view: UIViewController = view else { return }
        router?.displayAlert(title: "You died!", message: "No money for you!", from: view)
    }

    private func restartGameState() {
        guard let gameModel: GameModel = gameModel else { return }
        view?.restartView()
        view?.configureGame(with: gameModel)
        pointResultsCaptured = [HashablePoint: Bool]()
    }
}

extension GamePresenter: GameCanvaDelegate {
    func didDraw(toPoint point: CGPoint) {
        guard let gameModel: GameModel = gameModel else {
            return
        }
        let hashablePoint: HashablePoint = HashablePoint(point: point)
        if let _: Bool = pointResultsCaptured[hashablePoint] { // Point is already captured
            print("point captured")
            return
        }
        let pointResult: Bool = gameModel.shape.outerShapePath.contains(point) && !gameModel.shape.innerBezierpath.contains(point)
        pointResultsCaptured.updateValue(pointResult, forKey: hashablePoint)

    }

    func shouldDraw(fromPoint point: CGPoint) -> Bool {
        guard let gameModel: GameModel = gameModel else { return false }
        return gameModel.brackGroundShapePath.contains(point)
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
