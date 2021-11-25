//
//  GameLocalDataManager.swift
//  CutTheShape
//
//  Created by L Daniel De San Pedro on 23/11/21.
//

import Foundation
import UIKit
/*
    Explanation
        The local data manager is the manager who provides created models
        and local data. The interactor is the one who should ask for
        this type of data, in order to process it and prepare it for the
        presenter.
 
        Usually along with a local data manager, comes a API or remote
        data manager that manages the calls, and obtains the response.
 */
// MARK: - class - GameLocalDataManager
final class GameLocalDataManager: GameLocalDataManagerProtocol {
    // MARK: Methods
    func obtainGameView() -> GameViewModel {
        return GameViewModel(gameViewBackground: UIColor(hex: 0xEDE4A3),
                             cornerRadius: 10.0,
                             buttonBackGroundColor: UIColor(hex: 0x34C759),
                             initialButtonState: .start, initialTimer: String())
    }
    
    func obtainGameConfig() -> GameConfig? {
        do {
            guard let gameConfig: GameConfig = try JSONLoader.loadfile(withName: "GameConfig") else { return nil }
            return gameConfig
        } catch let error {
            print(error)
            return nil
        }
    }
}
