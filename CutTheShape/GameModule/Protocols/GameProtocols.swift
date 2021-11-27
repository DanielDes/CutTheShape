//
//  GameProtocols.swift
//  CutTheShape
//
//  Created by L Daniel De San Pedro on 23/11/21.
//

import Foundation
import UIKit

// MARK: protocol - GameViewRouter
protocol GameRouterProtocol: AnyObject {
    static func instantiateModule() -> UIViewController
    func displayAlert(title: String, message: String, from: UIViewController)
}

// MARK: protocol - GameViewProtocol
protocol GameViewProtocol: UIViewController {
    var presenter: GamePresenterProtocol? { get set }
    // Methods
    func configureView(with model: GameViewModel)
    func configureGame(with model: GameModel)
    func updateTimer(time: String)
    func restartView()
    func updateButton(withState state: ButtonState)
    func enableInteraction(_ interaction: Bool)
}

// MARK: protocol - GamePresenterProtocol
protocol GamePresenterProtocol: AnyObject {
    var interactor: GameInteractorProtocol? { get set }
    var router: GameRouterProtocol? { get set }
    var view: GameViewProtocol? { get set }
    // Methods
    func viewDidLoad(canvaBound: CGRect)
    func shouldStartGame()
    func shouldFinishGame()
}

// MARK: protocol - GameInteractorOutputProtocol
protocol GameInteractorOutputProtocol: AnyObject {
    func configureView(with model: GameViewModel)
    func configureGame(with model: GameModel)
    func shouldUpdateTimer(time: String)
    func playerDidWin()
    func playerDidLose()
}

// MARK: protocol - GameInteractorProtocol
protocol GameInteractorProtocol: AnyObject {
    var presenter: GameInteractorOutputProtocol? { get set }
    var localDataManager: GameLocalDataManagerProtocol? { get set }
    //Methods
    func obtainConfiguration(canvaBound: CGRect)
    func startGame()
    func finishGame(withScore score: Int)
}

// MARK: protocol - GameLocalDataManagerProtocol
protocol GameLocalDataManagerProtocol: AnyObject {
    func obtainGameView() -> GameViewModel
    func obtainGameConfig() -> GameConfig?
    func createGameModel(with dificulty: DificultyConfig, canvaBounds: CGRect) -> GameModel?
}

protocol GameCanvaDelegate: AnyObject {
    func didDraw(toPoint point: CGPoint)
    func shouldDraw(fromPoint point: CGPoint) -> Bool
}

