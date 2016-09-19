//
//  Player.swift
//  Dash
//
//  Created by Dan Halliday on 08/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

public class Player {

    fileprivate let view: PlayerView
    fileprivate let engine: PlayerEngine

    public var theme: PlayerTheme {
        didSet { self.view.update(theme: self.theme) }
    }

    fileprivate var state: PlayerState {
        didSet { self.view.update(state: self.state) }
    }

    init(engine: PlayerEngine = PlayerEngine(), view: PlayerView = PlayerView(),
         state: PlayerState = PlayerState(), theme: PlayerTheme = PlayerTheme()) {

        self.engine = engine
        self.view = view
        self.state = state
        self.theme = theme

        self.engine.delegate = self
        self.view.delegate = self

    }

    public func present(over view: UIView) {
        self.view.present(over: view)
    }

    public func present(over viewController: UIViewController) {
        self.view.present(over: viewController.view)
    }

    public func play() {
        self.engine.play()
    }

    public func pause() {
        self.engine.pause()
    }

    public func toggle() {
        self.state.maximised = self.state.minimised
    }

    public func minimise() {
        self.state.maximised = false
    }

    public func maximise() {
        self.state.maximised = true
    }

    public func load(title: String, body: String) {
        self.state.title = title
        self.state.body = body
        self.engine.load(text: body)
    }

    public func clear() {
        self.state.title = nil
        self.state.body = nil
    }

}

extension Player: PlayerEngineDelegate {

    func engineDidPlay(success: Bool) {
        self.state.playing = success
    }

    func engineDidPause(success: Bool) {
        self.state.paused = success
    }

    func engineDidProgress(position: Float) {
        self.state.position = position
    }

}

extension Player: PlayerViewDelegate {

    func toggleButtonWasPressed() {
        self.toggle()
    }

    func playButtonWasPressed() {
        self.play()
    }

    func pauseButtonWasPressed() {
        self.pause()
    }

}
