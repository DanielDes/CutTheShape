//
//  GameInteractor .swift
//  CutTheShape
//
//  Created by L Daniel De San Pedro on 23/11/21.
//

import Foundation

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
    
    // MARK: Init
    init(localDataManager: GameLocalDataManagerProtocol) {
        self.localDataManager = localDataManager
    }
    
    // MARK: Obtain Configuration
    func obtainConfiguration() {
        guard var viewModel: GameViewModel = localDataManager?.obtainGameView(),
              let config: GameConfig = localDataManager?.obtainGameConfig() else {
            // handle error of not getting config
            return
        }
        gameConfig = config
        setGame(dificulty: defaultDifficulty)
        viewModel.initialTimer = obtainMinutesFormat()
        presenter?.configureView(with: viewModel)
    }
    
    func startGame() {
        startTimer()
    }
    
    func finishGame() {
        resetTimer()
    }
    
    // MARK: Game Logic
    func startTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountdown() {
        guard secondsLeft > 0 else {
            resetTimer()
            presenter?.timeDidEnded()
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
    
    private func setGame(dificulty: Dificulty) {
        guard let dificultyConfig: DificultyConfig = gameConfig?.dificulties.first(where: { config in
            return config.dificulty == dificulty
        }) else { return }
        secondsLeft = dificultyConfig.timeCountdown
        currentDificultyConfig = dificultyConfig
    }
}
