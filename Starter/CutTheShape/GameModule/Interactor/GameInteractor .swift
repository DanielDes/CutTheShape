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

    
    // MARK: Init
    init(localDataManager: GameLocalDataManagerProtocol) {
        self.localDataManager = localDataManager
    }
    
    // MARK: Obtain Configuration
    func obtainConfiguration(canvaBound: CGRect) {

    }

    func obtainGameDificulties() -> [String]? {
       return [String]()
    }

    func changeDificulty(dificultyIndex: Int) {

    }
    
    func startGame() {

    }
    
    func finishGame(withScore score: Int) {

    }
    
    // MARK: Game Logic
    func startTimer() {

    }
    
    @objc func updateCountdown() {

    }
    
    // MARK: Other Methods
    private func obtainMinutesFormat() -> String {
        return ""
    }
    
    private func resetTimer() {
    }
    
    private func setGame(dificulty: DificultyConfig) {

    }

    private func getConfig(of dificulty: Dificulty, from gameConfig: GameConfig) -> DificultyConfig? {
        return nil
    }
}
