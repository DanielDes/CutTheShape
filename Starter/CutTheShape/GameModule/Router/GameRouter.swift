//
//  GameRouter.swift
//  CutTheShape
//
//  Created by L Daniel De San Pedro on 23/11/21.
//

import Foundation
import UIKit

/*
    Explanation
        The router is responsable to coordinate transitions to other
        modules. The router should instantiate another viper module,
        use it's view, and instantiate it using the current view. The
        router is also responsable to dismiss the current module.
 */

// MARK: class - GameRouter
final class GameRouter: GameRouterProtocol {
    // MARK: Static Methods
    static func instantiateModule() -> UIViewController {
        let localDataManager: GameLocalDataManagerProtocol = GameLocalDataManager()
        let interactor: GameInteractorProtocol = GameInteractor(localDataManager: localDataManager)
        let view: GameViewProtocol = GameViewController.instantiateView()
        let router: GameRouterProtocol = GameRouter()
        let _: GamePresenterProtocol = GamePresenter(view: view,
                                                             interactor: interactor,
                                                             router: router)
        return view
    }

    func displayAlert(title: String, message: String, from view:  UIViewController) {

    }

    func displayAlertSheet(title: String, message: String, actionSheetTitles: [String], handler: @escaping (UIAlertAction) -> Void, from view: UIViewController) {

    }
}
