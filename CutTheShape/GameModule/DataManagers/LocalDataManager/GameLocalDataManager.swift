//
//  GameLocalDataManager.swift
//  CutTheShape
//
//  Created by L Daniel De San Pedro on 23/11/21.
//

import Foundation
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
        return GameViewModel(helloWorldText: "Hello there!")
    }
}
