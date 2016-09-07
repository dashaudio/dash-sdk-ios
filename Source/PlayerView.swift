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

}

@objc class PlayerView: UIView {

    weak var delegate: PlayerViewDelegate?
    var maximised = true

    // DI state and theme here.

    let playButton: UIButton = {
        let button = UIButton()
        button.accessibilityLabel = "Play"
        button.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        return button
    }()

    let pauseButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Pause"
        button.backgroundColor = UIColor.red.withAlphaComponent(0.5)
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

        UIView.animate(withDuration: 0.35) {
            self.maximised = !self.maximised
            self.layoutSubviews()
        }
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
        self.backgroundView.isUserInteractionEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let layout = PlayerViewLayout(bounds: self.bounds, alignment: .standard, maximised: self.maximised)
        self.playButton.frame = layout.playButtonBounds()
        self.pauseButton.frame = layout.pauseButtonBounds()
        self.backgroundView.frame = layout.backgroundViewFrame()

        let style = PlayerViewStyle.standard
        self.backgroundView.layer.cornerRadius = min(style.rounding, self.backgroundView.bounds.size.height / 2)
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
