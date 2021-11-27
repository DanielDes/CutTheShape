//
//  CanvaView.swift
//  CutTheShape
//
//  Created by Luis Daniel De San Pedro Vazquez on 26/11/21.
//

import UIKit

class CanvaView: UIImageView {
    private var lastPoint: CGPoint = CGPoint.zero
    private var color: UIColor = UIColor.black
    private var brushWidth: CGFloat = 10.0
    private var opacity: CGFloat = 1.0
    private var swiped: Bool = false
    private var temporalView: UIImageView = UIImageView()
    var delegate: GameCanvaDelegate?

    func configureView() {
        temporalView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(temporalView)
        topAnchor.constraint(equalTo: temporalView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: temporalView.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: temporalView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: temporalView.trailingAnchor).isActive = true
    }

    func draw(path: UIBezierPath) {
        UIGraphicsBeginImageContext(self.frame.size)
        self.image?.draw(in: self.bounds,blendMode: .normal,alpha: 1.0)
        UIColor.black.setStroke()
        path.lineWidth = 2.0
        path.stroke()
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch: UITouch = touches.first else { return }
        swiped = false
        lastPoint = touch.location(in: self)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        swiped = true
        let currentPoint = touch.location(in: self)
        drawLine(from: lastPoint, to: currentPoint)
        lastPoint = currentPoint
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
          drawLine(from: lastPoint, to: lastPoint)
        }
        UIGraphicsBeginImageContext(self.frame.size)
        self.image?.draw(in: self.bounds, blendMode: .normal, alpha: 1.0)
        temporalView.image?.draw(in: self.bounds, blendMode: .normal, alpha: opacity)
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        temporalView.image = nil
    }

    private func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.frame.size)
        guard let context: CGContext = UIGraphicsGetCurrentContext(),
              let delegate: GameCanvaDelegate = delegate,
              delegate.shouldDraw(fromPoint: fromPoint) else { return }
        temporalView.image?.draw(in: self.bounds)
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setStrokeColor(color.cgColor)
        context.strokePath()
        temporalView.image = UIGraphicsGetImageFromCurrentImageContext()
        temporalView.alpha = opacity
        UIGraphicsEndImageContext()
        delegate.didDraw(toPoint: toPoint)
    }
}
