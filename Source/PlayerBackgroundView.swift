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

        if event != "cornerRadius" {
            return super.action(for: layer, forKey: event)
        }

        guard let animation = layer.animation(forKey: "bounds.size") as? CABasicAnimation else {
            return super.action(for: layer, forKey: event)
        }

        return Action(animation: animation.copy() as! CABasicAnimation, radius: layer.cornerRadius)

    }

    private class Action: NSObject, CAAction {

        var animation: CABasicAnimation
        var radius: CGFloat

        init(animation: CABasicAnimation, radius: CGFloat) {
            self.animation = animation
            self.radius = radius
        }

        func run(forKey event: String, object anObject: Any, arguments dict: [AnyHashable : Any]?) {

            guard let layer = anObject as? CALayer else {
                return
            }

            if self.animation.isAdditive {
                self.animation.fromValue = self.radius - layer.cornerRadius
                self.animation.toValue = 0
            } else {
                self.animation.fromValue = radius
                self.animation.toValue = layer.cornerRadius
            }

            self.animation.keyPath = "cornerRadius"

            layer.add(animation, forKey: "cornerRadius")

        }

    }

}
