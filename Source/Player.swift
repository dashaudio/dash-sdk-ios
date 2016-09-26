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
    private let store: ArticleStore

    fileprivate var state: PlayerState {
        didSet { self.view.update(state: self.state) }
    }

    public var theme: PlayerTheme {
        didSet { self.view.update(theme: self.theme) }
    }

    init(view: PlayerView = PlayerView(),
         engine: PlayerEngine = PlayerEngine(),
         store: ArticleStore = ArticleStore(),
         state: PlayerState = PlayerState(),
         theme: PlayerTheme = PlayerTheme()) {

        self.view = view
        self.engine = engine
        self.store = store
        self.state = state
        self.theme = theme

        self.view.delegate = self
        self.engine.delegate = self
        self.store.delegate = self

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

    public func load(url: URL) {
        self.store.fetch(id: url)
//        self.engine.load(url: url)
    }

    public func clear() {
        self.state.label = nil
    }

    public var playing: Bool {
        return self.state.playing
    }

}

extension Player: ArticleStoreDelegate {

    func fetchDidStart() {
        self.state.loading = true
    }

    func fetchDidSucceed(article: Article) {
        print(article)
        self.state.loading = false
    }

    func fetchDidFail() {
        print("failed")
        self.state.loading = false
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
