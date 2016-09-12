//
//  PlayerThemeTests.swift
//  Dash
//
//  Created by Dan Halliday on 08/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import XCTest
@testable import Dash

class PlayerThemeTests: XCTestCase {

    func testExample() {
        let _ = PlayerTheme()

        let _ = PlayerTheme(colors: .standard)
        let _ = PlayerTheme(colors: .init(foreground: .green, background: .white))

        let _ = PlayerTheme(alignment: .standard)
        let _ = PlayerTheme(alignment: .init(horizontal: .maxXEdge, vertical: .minYEdge))

        let _ = PlayerTheme(size: .standard)
        let _ = PlayerTheme(size: .small)
        let _ = PlayerTheme(size: .large)

        let _ = PlayerTheme(style: .standard)
        let _ = PlayerTheme(style: .init(rounding: 5, padding: 5))

        let _ = PlayerTheme(images: .standard)
        // let _ = PlayerTheme(images: .init(play: UIImage(named:"play")!, pause: UIImage(named: "pause")!))
    }

}
