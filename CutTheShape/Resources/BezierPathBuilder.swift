//
//  BezierPathBuilder.swift
//  CutTheShape
//
//  Created by Luis Daniel De San Pedro Vazquez on 26/11/21.
//

import Foundation
import UIKit

class BezierPathBuilder {
    func build(shape: Shape, type: ShapeType, bound: CGRect) -> UIBezierPath? {
        switch shape {
        case .square:
            return buildSquareShape(type: type, bound: bound)
        case .triangle:
            return buildTrianquelShape(type: type, bound: bound)
        case .circle:
            return buildCircleShape(type: type, bound: bound)
        case .unknown:
            return nil
        }
    }

    func buildBackgroundShape(bound: CGRect) -> UIBezierPath {
        UIBezierPath(arcCenter: CGPoint(x: bound.width * 0.5, y: bound.height * 0.5), radius: 150, startAngle: CGFloat(0), endAngle: CGFloat.pi * 2, clockwise: true)
    }

    private func buildSquareShape(type: ShapeType, bound: CGRect) -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: bound.width * 0.5, y: bound.height * 0.5), radius: 100, startAngle: CGFloat(0), endAngle: CGFloat.pi * 2, clockwise: true)
    }

    private func buildTrianquelShape(type: ShapeType, bound: CGRect) -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: bound.width * 0.5, y: bound.height * 0.5), radius: 100, startAngle: CGFloat(0), endAngle: CGFloat.pi * 2, clockwise: true)
    }

    private func buildCircleShape(type: ShapeType, bound: CGRect) -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: bound.width * 0.5, y: bound.height * 0.5), radius: 100, startAngle: CGFloat(0), endAngle: CGFloat.pi * 2, clockwise: true)
    }
}

enum ShapeType {
    case inner
    case outer
}
