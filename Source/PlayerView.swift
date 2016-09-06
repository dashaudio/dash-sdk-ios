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

    let playButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Play"
        button.backgroundColor = UIColor.red
        return button
    }()

    let pauseButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Pause"
        button.backgroundColor = UIColor.red
        return button
    }()

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
        self.addSubview(self.playButton)
        self.addSubview(self.pauseButton)
        self.playButton.addTarget(self, action: #selector(playButtonWasTapped), for: .touchUpInside)
        self.pauseButton.addTarget(self, action: #selector(pauseButtonWasTapped), for: .touchUpInside)
        self.backgroundColor = UIColor.green
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = PlayerViewLayout(bounds: self.bounds)
        self.playButton.frame = layout.playButtonBounds()
        self.pauseButton.frame = layout.pauseButtonBounds()
    }

}
