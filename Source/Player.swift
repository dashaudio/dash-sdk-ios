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
    private var state: PlayerState

    init(engine: PlayerEngine = PlayerEngine(), view: PlayerView = PlayerView(), state: PlayerState = PlayerState()) {
        self.engine = engine
        self.view = view
        self.state = state
        self.engine.delegate = self
        self.view.delegate = self
    }

    public func present(over view: UIView) {
        // TODO: Delegate to a presenter
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.frame = view.bounds
        self.view.layer.zPosition = CGFloat.greatestFiniteMagnitude // TODO: Some consideration here
        view.addSubview(self.view)
    }

    public func updateTheme(theme: PlayerTheme) {
        self.view.updateTheme(theme: theme)
    }

    public func play() {
        self.state.playing = false
        self.engine.play()
        self.view.updateState(state: self.state)
    }

    public func pause() {
        self.state.playing = false
        self.engine.pause()
        self.view.updateState(state: self.state)
    }

    func toggleMaximise() {
        if self.state.maximised {
            self.minimise()
        } else {
            self.maximise()
        }
    }

    public func minimise() {
        self.state.maximised = false
        self.view.updateState(state: self.state)
    }

    public func maximise() {
        self.state.maximised = true
        self.view.updateState(state: self.state)
    }

    // set text/url data

}

extension Player: PlayerEngineDelegate {

    // TODO

}

extension Player: PlayerViewDelegate {

    func playButtonWasPressed() {
        print("play button was pressed")
        self.play()
    }

    func pauseButtonWasPressed() {
        print("pause button was pressed")
        self.pause()
    }

    func maximiseToggleWasPressed() {
        print("maximise toggle was pressed")
        self.toggleMaximise()
    }

}
