//
//  PlayerViewLayout.swift
//  Dash
//
//  Created by Dan Halliday on 06/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//


enum PlayerViewSize: CGFloat {
    case small = 30
    case medium = 50
    case large = 80
    static let standard = PlayerViewSize.medium
}

struct PlayerViewColors {
    let foreground: UIColor
    let background: UIColor
    static let standard = PlayerViewColors(foreground: .red, background: .white)
}

struct PlayerViewImages {
    let play: UIImage
    let pause: UIImage
    static let standard = PlayerViewImages(play: UIImage(named: "play")!, pause: UIImage(named: "pause")!)
}

struct PlayerViewStyle {
    let rounding: CGFloat
    static let standard = PlayerViewStyle(rounding: 25)
}

enum PlayerViewSide {
    case top
    case right
    case bottom
    case left
}

struct PlayerViewAlignment {
    let horizontal: PlayerViewSide
    let vertical: PlayerViewSide
    static let standard = PlayerViewAlignment(horizontal: .left, vertical: .bottom)
}

struct PlayerViewTheme {
    let colors: PlayerViewColors
    let alignment: PlayerViewAlignment
    let size: PlayerViewSize
    let style: PlayerViewStyle
    let images: PlayerViewImages
}




//put all the data inisde 'theme'

struct PlayerViewTheme2 {
    let colors: Colors = .standard

    struct Colors {
        static let standard = Colors()
    }
}





//

let standard = PlayerViewTheme(colors: .standard, alignment: .standard, size: .standard, style: .standard, images: .standard)

let colors = PlayerViewColors(foreground: .green, background: .black)
let alignment = PlayerViewAlignment(horizontal: .right, vertical: .top)
let size = PlayerViewSize.large
let style = PlayerViewStyle(rounding: 5)
let images = PlayerViewImages(play: UIImage(named: "foo")!, pause: UIImage(named: "bar")!)

let custom = PlayerViewTheme(colors: colors, alignment: alignment, size: size, style: style, images: images)


struct PlayerViewState {
    let visible: Bool
    let maximised: Bool
    let playing: Bool
    let position: Double
}






struct PlayerViewLayout {

    let bounds: CGRect
    let maximised: Bool
    let alignment: PlayerViewAlignment

    let baseSize: CGFloat = 50
    let basePadding: CGFloat = 5

    // Should take both theme and state here
    init(bounds: CGRect, alignment: PlayerViewAlignment, maximised: Bool) {
        self.bounds = bounds
        self.maximised = maximised
        self.alignment = alignment
    }

    func workingFrame() -> CGRect {
        let y = self.alignment.vertical == .top ? 0 : self.bounds.maxY - self.baseSize
        let width = self.maximised ? self.bounds.size.width : self.baseSize
        return CGRect(x: 0, y: y, width: width, height: self.baseSize)
    }

    func backgroundViewFrame() -> CGRect {
        return self.workingFrame().insetBy(dx: self.basePadding, dy: self.basePadding)
    }

    func playButtonBounds() -> CGRect {
        var frame = self.workingFrame()
        frame.size.width = self.baseSize
        return frame
    }

    func pauseButtonBounds() -> CGRect {
        return self.playButtonBounds()
    }

}





