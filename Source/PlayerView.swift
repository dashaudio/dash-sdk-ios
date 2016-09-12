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

    weak var delegate: PlayerViewDelegate?

    var theme = PlayerTheme()
    var state = PlayerState()

    let toggleButton = UIButton()
    let playButton = UIButton()
    let pauseButton = UIButton()
    let titleLabel = UILabel()
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
        self.addSubview(self.titleLabel)
        self.addSubview(self.toggleButton)

        self.toggleButton.addTarget(self, action: #selector(toggleButtonWasPressed), for: .touchUpInside)
        self.playButton.addTarget(self, action: #selector(playButtonWasTapped), for: .touchUpInside)
        self.pauseButton.addTarget(self, action: #selector(pauseButtonWasTapped), for: .touchUpInside)

        self.backgroundView.isUserInteractionEnabled = false
        self.titleLabel.contentMode = .scaleToFill

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }

    func updateTheme(theme: PlayerTheme) {

        UIView.animate(withDuration: 0.25) {
            self.theme = theme
            self.layoutSubviews()
        }

    }

    func updateState(state: PlayerState) {

        UIView.animate(withDuration: 0.25) {
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

        self.titleLabel.text = "The podcast track title"
        self.titleLabel.frame = layout.titleLabelFrame()
        self.titleLabel.textColor = self.theme.colors.foreground
        self.titleLabel.font = UIFont.systemFont(ofSize: layout.titleLabelFontSize())

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
