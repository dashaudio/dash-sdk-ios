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
        didSet { self.view.updateTheme(theme: self.theme) }
    }

    public var state: PlayerState {
        didSet { self.view.updateState(state: self.state) }
    }

    init(engine: PlayerEngine = PlayerEngine(), view: PlayerView = PlayerView(),
         theme: PlayerTheme = PlayerTheme(), state: PlayerState = PlayerState()) {

        self.engine = engine
        self.view = view
        self.theme = theme
        self.state = state

        self.engine.delegate = self
        self.view.delegate = self

    }

    public func present(over view: UIView) {

        // TODO: Delegate to a presenter

        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.frame = view.bounds
        self.view.layer.zPosition = CGFloat(FLT_MAX) // TODO: Some consideration here

        view.addSubview(self.view)

    }

    public func present(over viewController: UIViewController) {
        self.present(over: viewController.view)
    }

    public func play() {
        self.engine.play()
    }

    public func pause() {
        self.engine.pause()
    }

    public func toggle() {

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

    public func load(title: String) {

        self.state.title = title
        self.view.updateState(state: state)
        
    }

}

extension Player: PlayerEngineDelegate {

    func engineDidPlay(success: Bool) {

        self.state.playing = success
        self.view.updateState(state: self.state)

    }

    func engineDidPause(success: Bool) {

        self.state.paused = success
        self.view.updateState(state: self.state)

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
