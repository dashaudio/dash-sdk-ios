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

    func maximiseToggleWasPressed()

}

@objc class PlayerView: UIView {

    weak var delegate: PlayerViewDelegate?

    var theme = PlayerTheme()
    var state = PlayerState()

    let playButton: UIButton = {
        let button = UIButton()
        button.accessibilityLabel = "Play"
        button.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        button.imageView?.tintColor = UIColor.white
        return button
    }()

    let pauseButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.titleLabel?.text = "Pause"
        button.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        button.imageView?.tintColor = UIColor.white
        return button
    }()

    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()

    func playButtonWasTapped() {
        self.delegate?.playButtonWasPressed()
    }

    func pauseButtonWasTapped() {
        self.delegate?.pauseButtonWasPressed()
    }

    func maximiseToggleWasPressed() {
        self.delegate?.maximiseToggleWasPressed()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.backgroundView)
        self.addSubview(self.playButton)
        self.addSubview(self.pauseButton)
        self.playButton.addTarget(self, action: #selector(playButtonWasTapped), for: .touchUpInside)
        self.pauseButton.addTarget(self, action: #selector(pauseButtonWasTapped), for: .touchUpInside)
        self.pauseButton.addTarget(self, action: #selector(maximiseToggleWasPressed), for: .touchUpInside)
        self.playButton.imageView?.image = self.theme.images.play
        self.pauseButton.imageView?.image = self.theme.images.pause
        self.backgroundView.isUserInteractionEnabled = false
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
        self.playButton.frame = layout.playButtonFrame()
        self.pauseButton.frame = layout.pauseButtonFrame()
        self.backgroundView.frame = layout.backgroundViewFrame()

        let rounding = self.theme.style.rounding
        let maxRounding = self.backgroundView.bounds.size.height / 2
        self.backgroundView.layer.cornerRadius = min(rounding, maxRounding)

        self.playButton.backgroundColor = self.theme.colors.foreground
        self.pauseButton.backgroundColor = self.theme.colors.foreground
        self.backgroundView.backgroundColor = self.theme.colors.background
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
