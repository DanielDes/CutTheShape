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

    func createGameModel(with dificulty: DificultyConfig, canvaBounds: CGRect) -> GameModel? {
        let shapeBuilder: BezierPathBuilder = BezierPathBuilder()
        guard let outerShape: UIBezierPath = shapeBuilder.build(shape: dificulty.shape, type: ShapeType.outer, bound: canvaBounds),
              let innerShape: UIBezierPath = shapeBuilder.build(shape: dificulty.shape, type: ShapeType.inner, bound: canvaBounds) else { return nil }
        let shape: ShapeModel = ShapeModel(outerShapePath:
                                            outerShape,
                                           innerBezierpath:
                                            innerShape)
        return GameModel(brackGroundShapePath: shapeBuilder.buildBackgroundShape(bound: canvaBounds), shape: shape)
    }
}
