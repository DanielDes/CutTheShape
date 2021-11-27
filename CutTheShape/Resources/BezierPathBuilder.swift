//
//  BezierPathBuilder.swift
//  CutTheShape
//
//  Created by Luis Daniel De San Pedro Vazquez on 26/11/21.
//

import Foundation
import UIKit

class BezierPathBuilder {
    private var innerShapeScale: Double = 0.95
    private var defaultRadius: CGFloat = 100
    private var squareSize: CGFloat = 150
    private var triangleSide: CGFloat = 150

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
        let squareSize: CGFloat = type == .inner ? self.squareSize * innerShapeScale : self.squareSize
        let xCoordinate: CGFloat = (bound.width * 0.5) - (squareSize * 0.5)
        let yCoordinate: CGFloat = (bound.height * 0.5) - (squareSize * 0.5)
        return UIBezierPath(rect: CGRect(x: xCoordinate, y: yCoordinate, width: squareSize, height: squareSize))
    }

    private func buildTrianquelShape(type: ShapeType, bound: CGRect) -> UIBezierPath {
        let centerY: CGFloat = bound.height * 0.5
        let centerX: CGFloat = bound.width * 0.5
        let triangeSide: CGFloat = type == .inner ? triangleSide * innerShapeScale : triangleSide
        let startX: CGFloat = centerX - triangeSide * 0.5
        let startY: CGFloat = centerY - triangeSide * 0.5
        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: startX, y: startY + triangeSide))
        path.addLine(to: CGPoint(x: startX + triangeSide, y: startY + triangeSide * 0.5))
        path.close()

        return path
    }

    private func buildCircleShape(type: ShapeType, bound: CGRect) -> UIBezierPath {
        let radius: CGFloat = type == .inner ? defaultRadius * innerShapeScale : defaultRadius
        return UIBezierPath(arcCenter: CGPoint(x: bound.width * 0.5, y: bound.height * 0.5), radius: radius, startAngle: CGFloat(0), endAngle: CGFloat.pi * 2, clockwise: true)
    }
}

enum ShapeType {
    case inner
    case outer
}
