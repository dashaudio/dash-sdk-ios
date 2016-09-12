//
//  PlayerBackgroundView.swift
//  Dash
//
//  Created by Dan Halliday on 08/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import UIKit

class PlayerBackgroundView: UIView {

    override func action(for layer: CALayer, forKey event: String) -> CAAction? {


        if event == "cornerRadius" {
            if let boundsAnimation = layer.animation(forKey: "bounds.size") as? CABasicAnimation {
                let animation = boundsAnimation.copy() as! CABasicAnimation
                animation.keyPath = "cornerRadius"
                let action = Action()
                action.pendingAnimation = animation
                action.priorCornerRadius = layer.cornerRadius
                return action
            }
        }
        return super.action(for: layer, forKey: event)


    }

    private class Action: NSObject, CAAction {
        var pendingAnimation: CABasicAnimation?
        var priorCornerRadius: CGFloat = 0
//        public func run(forKey event: String, object anObject: Any, arguments dict: [AnyHashable : Any]?)

        func run(forKey event: String, object anObject: Any, arguments dict: [AnyHashable : Any]?) {
            if let layer = anObject as? CALayer, let pendingAnimation = pendingAnimation {
                if pendingAnimation.isAdditive {
                    pendingAnimation.fromValue = priorCornerRadius - layer.cornerRadius
                    pendingAnimation.toValue = 0
                } else {
                    pendingAnimation.fromValue = priorCornerRadius
                    pendingAnimation.toValue = layer.cornerRadius
                }
                layer.add(pendingAnimation, forKey: "cornerRadius")
            }
        }
    }

}
