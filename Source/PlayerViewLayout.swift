//
//  PlayerViewLayout.swift
//  Dash
//
//  Created by Dan Halliday on 06/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

struct PlayerViewLayout {

    let bounds: CGRect
    let padding: CGFloat = 10
    let height: CGFloat = 50

    init(bounds: CGRect) {
        self.bounds = bounds
    }

    func playButtonBounds() -> CGRect {
        let side = self.height - (2 * self.padding)
        let y = self.padding + (self.bounds.size.height - self.height) / 2
        let rect = CGRect(x: self.padding, y: y, width: side, height: side)
        return rect
    }

    func pauseButtonBounds() -> CGRect {
        return self.playButtonBounds()
    }

}
