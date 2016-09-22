//
//  Player.swift
//  Dash
//
//  Created by Dan Halliday on 08/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

public class Player {

    private let view: PlayerView
    private let engine: PlayerEngine

    fileprivate var state: PlayerState {
        didSet { self.view.update(state: self.state) }
    }

    public var theme: PlayerTheme {
        didSet { self.view.update(theme: self.theme) }
    }

    init(view: PlayerView = PlayerView(), engine: PlayerEngine = PlayerEngine(),
         state: PlayerState = PlayerState(), theme: PlayerTheme = PlayerTheme()) {

        self.view = view
        self.engine = engine
        self.state = state
        self.theme = theme

        self.view.delegate = self
        self.engine.delegate = self

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

    public func load(url: String, title: String) {
        self.state.title = title
        self.engine.load(url: url)
    }

    public func clear() {
        self.state.title = nil
    }

    public var playing: Bool {
        return self.state.playing
    }

}

extension Player: PlayerEngineDelegate {

    func engineDidPlay(success: Bool) {
        self.state.playing = success
    }

    func engineDidPause(success: Bool) {
        self.state.paused = success
    }

    func engineDidProgress(position: Double) {
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
