//
//  PlayerEngine.swift
//  Dash
//
//  Created by Dan Halliday on 08/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import AVFoundation
import MediaPlayer

protocol AudioEngineDelegate: class {

    func loadDidStart()
    func loadDidSucceed()
    func loadDidFail()

    func playbackDidStart()
    func playbackDidStop()
    func playbackDidFail()

    func playbackPositionDidChange(position: Double)

}

class AudioEngine: NSObject {

    weak var delegate: AudioEngineDelegate? = nil

    var player: AVPlayer? = nil
    var playWhenReady = false

    var observer: Any? = nil
    var observerContext: Any? = nil

    override init() {

        super.init()

        // TODO: Carefully consider a shorter lifetime for session and event handling

        self.enableAudioSession()
        self.enableRemoteControlEvents()

    }

    func load(url: URL) {

        // TODO: Optimise out loading the same content twice
        // TODO: More sophisticated caching
        // TODO: Listen to playback ended event

        self.pause()

        self.delegate?.playbackPositionDidChange(position: 0)
        self.delegate?.loadDidStart()

        let player = AVPlayer(url: url)

        self.player?.currentItem!.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
        player.currentItem!.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.new], context: nil)

        self.player = player

    }

    func play() {

        guard let player = self.player else { return }
        guard let duration = player.currentItem?.duration else { return }

        if player.status != .readyToPlay {
            self.playWhenReady = true
            return
        }

        let interval = CMTime(value: 1, timescale: 1)
        let queue = DispatchQueue.main

        self.observer = player.addPeriodicTimeObserver(forInterval: interval, queue: queue) { time in
            self.delegate?.playbackPositionDidChange(position: time.seconds / duration.seconds)
        }

        player.play()
        self.delegate?.playbackDidStart()

    }

    func pause() {

        guard let player = self.player else { return }

        player.pause()
        self.delegate?.playbackDidStop() // TODO: Check player.status

        if let observer = self.observer {
            player.removeTimeObserver(observer)
            self.observer = nil
        }

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

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        let status = AVPlayerStatus(rawValue: change![NSKeyValueChangeKey.newKey] as! Int)!

        switch status {

        case .unknown:
            break

        case .readyToPlay:
            self.delegate?.loadDidSucceed()
            if self.playWhenReady {
                self.playWhenReady = false
                self.play()
            }

        case .failed:
            self.delegate?.loadDidFail()

        }

    }

}
