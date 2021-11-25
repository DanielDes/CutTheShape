//
//  GameViewModel.swift
//  CutTheShape
//
//  Created by L Daniel De San Pedro on 23/11/21.
//

import Foundation
import UIKit

struct GameViewModel {
    var gameViewBackground: UIColor
    var cornerRadius: CGFloat
    var buttonBackGroundColor: UIColor
    var initialButtonState: ButtonState
    var initialTimer: String
}

enum ButtonState: String {
    case start = "Comenzar"
    case finish = "Terminar"
}
