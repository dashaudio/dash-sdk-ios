//
//  PlayerEngine.swift
//  Dash
//
//  Created by Dan Halliday on 08/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import AVFoundation
import MediaPlayer

protocol PlayerEngineDelegate: class {

    func engineDidPlay(success: Bool)
    func engineDidPause(success: Bool)
    
}

class PlayerEngine {

    weak var delegate: PlayerEngineDelegate?

    init() {

        // TODO: Carefully consider a shorter lifetime for session and event handling

        self.enableAudioSession()
        self.enableRemoteControlEvents()

    }

    func play() {
        self.delegate?.engineDidPlay(success: true)
    }

    func pause() {
        self.delegate?.engineDidPause(success: true)
    }

    func enableAudioSession() {

        let session = AVAudioSession.sharedInstance()

        do { try session.setActive(true) } catch {
            print(error)
        }

        do { try session.setCategory(AVAudioSessionCategoryPlayback) } catch {
            print(error)
        }

        do { try session.setMode(AVAudioSessionModeSpokenAudio) } catch {
            print(error)
        }

        // TODO: Error handling scheme and UI display for low level errors

    }

    func disableAudioSession() {

        let session = AVAudioSession.sharedInstance()

        do { try session.setActive(false) } catch {
            print(error)
        }

    }

    func enableRemoteControlEvents() {

        let center = MPRemoteCommandCenter.shared()

        center.playCommand.addTarget { event -> MPRemoteCommandHandlerStatus in
            return .success
        }

        center.pauseCommand.addTarget { event -> MPRemoteCommandHandlerStatus in
            return .success
        }

    }

    func disableRemoteControlEvents() {
        // ?
    }
    
}
