//
//  SceneDelegate.swift
//  CutTheShape
//
//  Created by L Daniel De San Pedro on 23/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let mainScene = scene as? UIWindowScene else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = mainScene
        window?.rootViewController = GameRouter.instantiateModule()
        window?.makeKeyAndVisible()
    }
}

