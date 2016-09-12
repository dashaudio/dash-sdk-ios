//
//  PlayerViewLayout.swift
//  Dash
//
//  Created by Dan Halliday on 06/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//


struct PlayerViewLayout {

    let theme: PlayerTheme
    let state: PlayerState
    let bounds: CGRect

    init(theme: PlayerTheme, state: PlayerState, bounds: CGRect) {
        self.theme = theme
        self.state = state
        self.bounds = bounds
    }

    func workingFrame() -> CGRect {

        // TODO: Calculate working frame upfront, not every time needed

        let width = self.state.maximised ? self.bounds.size.width : self.theme.size.rawValue
        let height = self.theme.size.rawValue
        let y: CGFloat
        let x: CGFloat

        switch self.theme.alignment.vertical {
        case .minYEdge: y = 0
        case .maxYEdge: y = self.bounds.size.height - self.theme.size.rawValue
        default: y = 0
        }

        switch (self.theme.alignment.horizontal, self.state.maximised) {
        case (.maxXEdge, false): x = self.bounds.size.width - self.theme.size.rawValue
        default: x = 0
        }

        return CGRect(x: x, y: y, width: width, height: height)

    }

    func leftButtonFrame() -> CGRect {

        var frame = self.workingFrame()
        frame.size.width = self.theme.size.rawValue

        if self.state.maximised == false && self.theme.alignment.horizontal == .maxXEdge {
            frame.origin.x = self.bounds.width - self.theme.size.rawValue
        }

        return frame.insetBy(dx: self.theme.style.padding, dy: self.theme.style.padding)

    }

    func rightButtonFrame() -> CGRect {

        var frame = self.workingFrame()
        frame.size.width = self.theme.size.rawValue
        frame.origin.x = self.bounds.width - self.theme.size.rawValue

        if self.state.maximised == false && self.theme.alignment.horizontal == .minXEdge {
            frame.origin.x = 0
        }

        return frame.insetBy(dx: self.theme.style.padding, dy: self.theme.style.padding)

    }

    func centralFrame() -> CGRect {

        var frame = self.workingFrame()

        let dx = self.theme.size.rawValue - self.theme.style.padding
        frame.origin.x += dx
        frame.size.width -= dx * 2

        let dy = self.theme.style.padding
        frame.origin.y += dy
        frame.size.height -= dy * 2

        return frame

    }

    func primaryButtonFrame() -> CGRect {
        return self.theme.alignment.horizontal == .minXEdge ? self.leftButtonFrame() : self.rightButtonFrame()
    }

    func secondaryButtonFrame() -> CGRect {
        return self.theme.alignment.horizontal == .maxXEdge ? self.leftButtonFrame() : self.rightButtonFrame()
    }

    func backgroundViewFrame() -> CGRect {
        let padding = self.theme.style.padding
        return self.workingFrame().insetBy(dx: padding, dy: padding)
    }

    func backgroundViewRounding() -> CGFloat {
        let maxPadding = self.backgroundViewFrame().size.height / 2
        return min(self.theme.style.rounding, maxPadding)
    }

    func toggleButtonFrame() -> CGRect {
        return self.primaryButtonFrame()
    }

    func playButtonFrame() -> CGRect {
        return self.secondaryButtonFrame()
    }

    func playButtonAlpha() -> CGFloat {
        return (self.state.maximised && !self.state.playing) ? 1 : 0
    }

    func pauseButtonFrame() -> CGRect {
        return self.secondaryButtonFrame()
    }

    func pauseButtonAlpha() -> CGFloat {
        return (self.state.maximised && self.state.playing) ? 1 : 0
    }

    func titleLabelFrame() -> CGRect {

        var frame = self.centralFrame()

        frame.origin.y += self.theme.size.rawValue * (0.2 - 0.05)
        frame.size.height -= self.theme.size.rawValue * 0.2 * 2.5

        return frame

    }

    func titleLabelFontSize() -> CGFloat {
        return self.titleLabelFrame().size.height * 0.8
    }

    func titleLabelAlpha() -> CGFloat {
        return self.state.maximised ? 1 : 0
    }

    func positionProgressViewFrame() -> CGRect {

        var frame = self.centralFrame()

        frame.origin.y += (self.theme.size.rawValue * 0.8) - (self.theme.style.padding * 2) - 2
        frame.size.height = 2

        return frame

    }

    func positionProgressViewAlpha() -> CGFloat {
        return self.state.maximised ? 1 : 0
    }

}
