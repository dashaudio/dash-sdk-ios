//
//  PlayerView.swift
//  Dash
//
//  Created by Dan Halliday on 06/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import UIKit

protocol PlayerViewDelegate: class {

    func playButtonWasPressed()
    func pauseButtonWasPressed()

    func toggleButtonWasPressed()

}

@objc class PlayerView: UIView {

    // TODO: Factor out presenter responsibility
    // TODO: DI presenter and layout

    weak var delegate: PlayerViewDelegate?

    var theme = PlayerTheme()
    var state = PlayerState()

    let toggleButton = UIButton()
    let playButton = UIButton()
    let pauseButton = UIButton()
    let titleLabel = UILabel()
    let titleLabelContainer = UIView()
    let positionProgressView = UIProgressView()
    let backgroundView = PlayerBackgroundView()

    func toggleButtonWasPressed() {
        self.delegate?.toggleButtonWasPressed()
    }

    func playButtonWasTapped() {
        self.delegate?.playButtonWasPressed()
    }

    func pauseButtonWasTapped() {
        self.delegate?.pauseButtonWasPressed()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    required override init(frame: CGRect) {

        super.init(frame: frame)

        self.addSubview(self.backgroundView)
        self.addSubview(self.playButton)
        self.addSubview(self.pauseButton)
        self.addSubview(self.titleLabelContainer)
        self.titleLabelContainer.addSubview(self.titleLabel)
        self.addSubview(self.positionProgressView)
        self.addSubview(self.toggleButton)

        self.toggleButton.addTarget(self, action: #selector(toggleButtonWasPressed), for: .touchUpInside)
        self.playButton.addTarget(self, action: #selector(playButtonWasTapped), for: .touchUpInside)
        self.pauseButton.addTarget(self, action: #selector(pauseButtonWasTapped), for: .touchUpInside)

        self.backgroundView.isUserInteractionEnabled = false
        self.titleLabel.contentMode = .left
        self.titleLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }

    func present(over view: UIView) {

        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.frame = view.bounds
        self.layer.zPosition = CGFloat(FLT_MAX) // TODO: Some consideration here

        view.addSubview(self)

    }

    func update(theme: PlayerTheme) {

        UIView.animate(withDuration: 0.3) {
            self.theme = theme
            self.layoutSubviews()
        }

    }

    func update(state: PlayerState) {

        UIView.animate(withDuration: 0.3) {
            self.state = state
            self.layoutSubviews()
        }

    }

    override func layoutSubviews() {

        super.layoutSubviews()

        let layout = PlayerViewLayout(theme: self.theme, state: self.state, bounds: self.bounds)

        self.toggleButton.frame = layout.toggleButtonFrame()
        self.playButton.frame = layout.playButtonFrame()
        self.pauseButton.frame = layout.pauseButtonFrame()
        self.backgroundView.frame = layout.backgroundViewFrame()
        self.backgroundView.layer.cornerRadius = layout.backgroundViewRounding()

        self.toggleButton.tintColor = self.theme.colors.foreground
        self.toggleButton.setBackgroundImage(self.theme.images.toggle, for: .normal)

        self.playButton.tintColor = self.theme.colors.foreground
        self.playButton.setBackgroundImage(self.theme.images.play, for: .normal)
        self.playButton.alpha = layout.playButtonAlpha()

        self.pauseButton.tintColor = self.theme.colors.foreground
        self.pauseButton.setBackgroundImage(self.theme.images.pause, for: .normal)
        self.pauseButton.alpha = layout.pauseButtonAlpha()

        self.backgroundView.backgroundColor = self.theme.colors.background

        self.titleLabel.text = self.state.title
        self.titleLabelContainer.frame = layout.titleLabelFrame()
        self.titleLabel.textColor = self.theme.colors.foreground
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: layout.titleLabelFontSize())
        self.titleLabel.alpha = layout.titleLabelAlpha()

        self.positionProgressView.frame = layout.positionProgressViewFrame()
        self.positionProgressView.progress = self.state.position
        self.positionProgressView.trackTintColor = self.theme.colors.background
        self.positionProgressView.progressTintColor = self.theme.colors.foreground
        self.positionProgressView.alpha = layout.positionProgressViewAlpha()

    }

    func styleSubviews() {
        // TODO: Move expensive non-layout here (eg. images)
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {

        if super.point(inside: point, with: event) == false { return false }

        return self.subviews.filter({
            $0.isUserInteractionEnabled == true &&
            $0.isHidden == false &&
            $0.point(inside: self.convert(point, to: $0), with: event)
        }).count > 0

    }

}
