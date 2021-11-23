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
    
    // MARK: Init
    init(localDataManager: GameLocalDataManagerProtocol) {
        self.localDataManager = localDataManager
    }
    
    // MARK: Obtain Configuration
    func obtainConfiguration() {
        guard let viewModel: GameViewModel = localDataManager?.obtainGameView() else { return }
        presenter?.configureView(with: viewModel)
    }
}
