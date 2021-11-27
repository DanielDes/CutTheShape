//
//  GameInteractor .swift
//  CutTheShape
//
//  Created by L Daniel De San Pedro on 23/11/21.
//

import Foundation
import UIKit

/*
    Explanation
        The interactor will hold all the logic related to the game. For
        example, the conditions for winning and losing. The next shape that
        will be shown, and other parameter that will affect the game
        mainly.
 */

// MARK: - class - GameInteractor
final class GameInteractor: GameInteractorProtocol {
    // MARK: Atributes
    weak var presenter: GameInteractorOutputProtocol?
    var localDataManager: GameLocalDataManagerProtocol?
    var gameTimer: Timer = Timer()
    
    // MARK: Private Attributes
    private var secondsLeft: Int = 60
    private var gameConfig: GameConfig?
    private var currentDificultyConfig: DificultyConfig?
    private let defaultDifficulty: Dificulty = .easy
    private var currentShapeIndex: Int = 0
    private var canvaBound: CGRect?
    // MARK: Score
    private var requiredScoreToWin: Int = 0
    private var uperScoreLimit: Int = 1500
    private var underScoreLimit: Int = 800
    
    // MARK: Init
    init(localDataManager: GameLocalDataManagerProtocol) {
        self.localDataManager = localDataManager
    }
    
    // MARK: Obtain Configuration
    func obtainConfiguration(canvaBound: CGRect) {
        guard var viewModel: GameViewModel = localDataManager?.obtainGameView(),
              let config: GameConfig = localDataManager?.obtainGameConfig(),
              let dificultyConfig: DificultyConfig = getConfig(of: defaultDifficulty, from: config),
              let gameModel: GameModel = localDataManager?.createGameModel(with: dificultyConfig, canvaBounds: canvaBound)
        else {
            // handle error of not getting config
            return
        }
        self.canvaBound = canvaBound
        gameConfig = config
        setGame(dificulty: dificultyConfig)
        viewModel.initialTimer = obtainMinutesFormat()
        presenter?.configureView(with: viewModel)
        presenter?.configureGame(with: gameModel)
    }

    func obtainGameDificulties() -> [String]? {
        guard let gameConfig = gameConfig else {
            return nil
        }
        let dificultyTitles: [String] = gameConfig.dificulties.map { dificultiConfig in
            return dificultiConfig.dificulty.rawValue.capitalized
        }
        return dificultyTitles
    }

    func changeDificulty(dificultyIndex: Int) {
        guard let dificultyConfig: DificultyConfig = gameConfig?.dificulties[dificultyIndex],
              let canvaBound: CGRect = canvaBound,
              let gameModel: GameModel = localDataManager?.createGameModel(with: dificultyConfig, canvaBounds: canvaBound) else { return }
        setGame(dificulty: dificultyConfig)
        presenter?.shouldUpdateTimer(time: obtainMinutesFormat())
        presenter?.configureGame(with: gameModel)
        resetTimer()
        
    }
    
    func startGame() {
        startTimer()
        requiredScoreToWin = Int.random(in: underScoreLimit...uperScoreLimit)
    }
    
    func finishGame(withScore score: Int) {
        if score >= requiredScoreToWin {
            presenter?.playerDidWin()
        } else {
            presenter?.playerDidLose()
        }
        print("Score: \(score)")
        print("Required: \(requiredScoreToWin)")
        resetTimer()
    }
    
    // MARK: Game Logic
    func startTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountdown() {
        guard secondsLeft > 0 else {
            resetTimer()
            presenter?.playerDidLose()
            return
        }
        secondsLeft -= 1
        presenter?.shouldUpdateTimer(time: obtainMinutesFormat())
    }
    
    // MARK: Other Methods
    private func obtainMinutesFormat() -> String {
        let minutes: Int = (secondsLeft % 3600) / 60
        let seconds: Int = (secondsLeft % 3600) % 60
        return "\(minutes):\(seconds < 10 ? "0" + seconds.description : seconds.description)"
    }
    
    private func resetTimer() {
        gameTimer.invalidate()
        secondsLeft = currentDificultyConfig?.timeCountdown ?? 300
        presenter?.shouldUpdateTimer(time: obtainMinutesFormat())
    }
    
    private func setGame(dificulty: DificultyConfig) {
        secondsLeft = dificulty.timeCountdown
        currentDificultyConfig = dificulty
    }

    private func getConfig(of dificulty: Dificulty, from gameConfig: GameConfig) -> DificultyConfig? {
        return gameConfig.dificulties.first { dificultyConfig in
            return dificultyConfig.dificulty == dificulty
        }
    }
}
