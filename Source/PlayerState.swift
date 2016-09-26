//
//  PlayerState.swift
//  Dash
//
//  Created by Dan Halliday on 08/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

public struct PlayerState {

    public var visible: Bool = true
    public var maximised: Bool = false
    public var playing: Bool = false
    public var loading: Bool = false
    public var position: Double = 0

    public var label: String? = nil

}

extension PlayerState {

    var hidden: Bool {
        get { return self.hidden == false }
        set { self.hidden = newValue == false }
    }

    var minimised: Bool {
        get { return self.maximised == false }
        set { self.maximised = newValue == false }
    }

    var paused: Bool {
        get { return self.playing == false }
        set { self.playing = newValue == false }
    }

}
