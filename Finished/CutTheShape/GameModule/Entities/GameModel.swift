//
//  GameModel.swift
//  CutTheShape
//
//  Created by Luis Daniel De San Pedro Vazquez on 26/11/21.
//

import Foundation
import UIKit

struct GameModel {
    // Bezier path that defines the background shape
    var brackGroundShapePath: UIBezierPath
    // Shape model
    var shape: ShapeModel
}

struct ShapeModel {
    // Outer path of the shape
    var outerShapePath: UIBezierPath
    // Inner path of the shape
    var innerBezierpath: UIBezierPath
}
