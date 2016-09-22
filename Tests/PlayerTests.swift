//
//  PlayerTests.swift
//  Dash
//
//  Created by Dan Halliday on 22/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import XCTest
@testable import Dash

class PlayerTests: XCTestCase {
    
    func testSingletonInterface() {

        let myView = UIView()
        let myViewController = UIViewController()

        // let myArticleUrl = "first-time-buyers"
        // let myArticleTitle = "First Time Buyers"

        Dash.shared.player.present(over: myView)
        Dash.shared.player.present(over: myViewController)

        // TODO Dash.shared.player.load(url: myArticleUrl, title: myArticleTitle)
        Dash.shared.player.clear()

        Dash.shared.player.play()
        Dash.shared.player.pause()

        Dash.shared.player.minimise()
        Dash.shared.player.maximise()
        Dash.shared.player.toggle()

        Dash.shared.player.theme.colors.foreground = UIColor.blue
        Dash.shared.player.theme.alignment.horizontal = .maxXEdge
        Dash.shared.player.theme.size = .large
        Dash.shared.player.theme.style.padding = 8
        // TODO Dash.shared.player.theme.images.play = UIImage(named: "play")!

    }

}
