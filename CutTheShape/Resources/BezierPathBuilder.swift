//
//  BezierPathBuilder.swift
//  CutTheShape
//
//  Created by Luis Daniel De San Pedro Vazquez on 26/11/21.
//

import Foundation
import UIKit

class BezierPathBuilder {
    func build(shape: Shape, type: ShapeType) -> UIBezierPath? {
        switch shape {
        case .square:
            return buildSquareShape(type: type)
        case .triangle:
            return buildTrianquelShape(type: type)
        case .circle:
            return buildCircleShape(type: type)
        case .unknown:
            return nil
        }
    }

    func buildBackgroundShape() -> UIBezierPath {
        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: 100, y: 100))
        return path
    }

    private func buildSquareShape(type: ShapeType) -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 100, startAngle: CGFloat(0), endAngle: CGFloat.pi * 2, clockwise: true)
    }

    private func buildTrianquelShape(type: ShapeType) -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 100, startAngle: CGFloat(0), endAngle: CGFloat.pi * 2, clockwise: true)
    }

    private func buildCircleShape(type: ShapeType) -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 100, startAngle: CGFloat(0), endAngle: CGFloat.pi * 2, clockwise: true)
    }
}

enum ShapeType {
    case inner
    case outer
}
