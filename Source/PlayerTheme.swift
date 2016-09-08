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

    public init(colors: Colors = .standard, alignment: Alignment = .standard, size: Size = .standard,
         style: Style = .standard, images: Images = .standard) {
        self.colors = colors
        self.alignment = alignment
        self.size = size
        self.style = style
        self.images = images
    }

    public struct Colors {
        public var foreground: UIColor
        public var background: UIColor

        public static let standard = Colors(foreground: .blue, background: .white)
        public static let grayscale = Colors(foreground: .gray, background: .white)
    }

    public struct Alignment {
        public var horizontal: CGRectEdge
        public var vertical: CGRectEdge

        public static let standard = Alignment(horizontal: .minXEdge, vertical: .maxYEdge)
    }

    public enum Size: CGFloat {
        case small = 30
        case medium = 50
        case large = 80

        public static let standard = Size.medium
    }

    public struct Style {
        public var rounding: CGFloat
        public var padding: CGFloat

        public static let standard = Style(rounding: 80, padding: 10)
    }

    public struct Images {
        public var play: UIImage
        public var pause: UIImage

        public static let standard: Images = {
            let frameworkBundle = Bundle(for: Dash.self)
            let play = UIImage(named: "play", in: frameworkBundle, compatibleWith: nil)!
            return Images(play: play, pause: play)
        }()
    }

}
