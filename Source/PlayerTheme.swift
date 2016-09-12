//
//  PlayerTheme.swift
//  Dash
//
//  Created by Dan Halliday on 08/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import UIKit

public struct PlayerTheme {

    public var colors: Colors
    public var alignment: Alignment
    public var size: Size
    public var style: Style
    public var images: Images

    public init(colors: Colors = .standard, alignment: Alignment = .standard,
                size: Size = .standard, style: Style = .standard, images: Images = .standard) {

        self.colors = colors
        self.alignment = alignment
        self.size = size
        self.style = style
        self.images = images

    }

    public struct Colors {

        public var foreground: UIColor
        public var background: UIColor

        public static let standard: Colors = {

            let whiteColor = UIColor.white
            let tintColor = UIView().tintColor!

            return Colors(foreground: whiteColor, background: tintColor)

        }()

    }

    public struct Alignment {

        public var horizontal: CGRectEdge
        public var vertical: CGRectEdge

        public static let standard = Alignment(horizontal: .minXEdge, vertical: .maxYEdge)

    }

    public enum Size: CGFloat {

        case small = 40
        case medium = 50
        case large = 60

        public static let standard = Size.medium

    }

    public struct Style {

        public var rounding: CGFloat
        public var padding: CGFloat

        public static let standard = Style(rounding: 5, padding: 5)

    }

    public struct Images {

        public var toggle: UIImage
        public var play: UIImage
        public var pause: UIImage

        public static let standard: Images = {

            let bundle = Bundle(for: Player.self)

            let toggle = UIImage(named: "toggle", in: bundle, compatibleWith: nil)!
            let play = UIImage(named: "play", in: bundle, compatibleWith: nil)!
            let pause = UIImage(named: "pause", in: bundle, compatibleWith: nil)!

            return Images(toggle: toggle, play: play, pause: pause)

        }()

    }

}
