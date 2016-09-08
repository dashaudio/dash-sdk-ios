//
//  PlayerBackgroundView.swift
//  Dash
//
//  Created by Dan Halliday on 08/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import UIKit

class PlayerBackgroundView: UIView {

//    override func action(for layer: CALayer, forKey event: String) -> CAAction? {
//
//        TODO: Fix this code so that cornerRadius is animated, should anybody change it live
//        let action = super.action(for: layer, forKey: event)
//
//        if event != "cornerRadius" { return action }
//        guard let boundsAction = self.action(for: layer, forKey: "bounds") as? CABasicAnimation else { return action }
//        guard let fromValue = boundsAction.fromValue as? NSValue else { return action }
//
//
//        let cornerRadiusAction = CABasicAnimation(keyPath: "cornerRadius")
//        cornerRadiusAction.delegate = boundsAction.delegate
//        cornerRadiusAction.duration = boundsAction.duration
//        cornerRadiusAction.fillMode = boundsAction.fillMode
//        cornerRadiusAction.timingFunction = boundsAction.timingFunction
//
//        let fromBounds = fromValue.cgRectValue
//        let fromRadius = fromBounds.size.height / 2 // Got to set the right radius!!!
//
//        cornerRadiusAction.fromValue = NSNumber(floatLiteral: Double(fromRadius))
//        return cornerRadiusAction
//
//    }

}
