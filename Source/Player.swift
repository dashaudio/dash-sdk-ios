//
//  Player.swift
//  Dash
//
//  Created by Dan Halliday on 08/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

public class Player {

    fileprivate let view: PlayerView
    fileprivate let engine: AudioEngine
    fileprivate let store: ArticleStore

    fileprivate var state: PlayerState {
        didSet { self.view.update(state: self.state) }
    }

    public var theme: PlayerTheme {
        didSet { self.view.update(theme: self.theme) }
    }

    init(view: PlayerView = PlayerView(),
         engine: AudioEngine = AudioEngine(),
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
        // self.engine.load(url: url)
    }

    public func clear() {
        self.state.article = nil
    }

    public var playing: Bool {
        return self.state.playing
    }

}

extension Player: ArticleStoreDelegate {

    func fetchDidStart() {
        self.state.loading = true
        self.state.article = nil
    }

    func fetchDidSucceed(article: Article) {
        // self.state.loading = false
        self.state.article = article
        self.engine.load(url: article.audio)
    }

    func fetchDidFail() {
        self.state.loading = false
        self.state.article = nil
    }

}

extension Player: AudioEngineDelegate {

    func loadDidStart() {
        self.state.loading = true
    }

    func loadDidSucceed() {
        self.state.loading = false
    }

    func loadDidFail() {
        self.state.loading = false
        // self.state.error = true?
    }

    func playbackDidStart() {
        self.state.playing = true
    }

    func playbackDidStop() {
        self.state.playing = false
    }

    func playbackDidFail() {
        self.state.playing = false
        // self.state.error = true?
    }

    func playbackPositionDidChange(position: Double) {
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
