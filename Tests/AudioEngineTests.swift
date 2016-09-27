//
//  AudioEngineTests.swift
//  Dash
//
//  Created by Dan Halliday on 27/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import XCTest
@testable import Dash

class AudioEngineTests: XCTestCase {

    private var engine: AudioEngine!
    private var spy: AudioEngineSpy!

    private var timeout = 5.0

    private let validFilePath = Bundle(for: AudioEngineTests.self).path(forResource: "Test", ofType: "m4a")!
    private let invalidFilePath = "invalid-file-path"

    override func setUp() {

        super.setUp()

        self.engine = AudioEngine()
        self.spy = AudioEngineSpy()

    }

    func testEngineLoadsAValidFile() {

        self.spy.loadDidStartExpectation = self.expectation(description: "load did start")
        self.spy.loadDidSucceedExpectation = self.expectation(description: "load did succeed")

        self.engine.delegate = spy
        self.engine.load(url: URL(fileURLWithPath: self.validFilePath))

        self.waitForExpectations(timeout: self.timeout, handler: nil)

    }

    func testEngineFailsToLoadAnInvalidFile() {

        self.spy.loadDidStartExpectation = self.expectation(description: "load did start")
        self.spy.loadDidFailExpectation = self.expectation(description: "load did fail")

        self.engine.delegate = spy
        self.engine.load(url: URL(fileURLWithPath: self.invalidFilePath))

        self.waitForExpectations(timeout: self.timeout, handler: nil)

    }

    func testEnginePlaysAValidFile() {

        self.spy.playbackDidStartExpectation = self.expectation(description: "playback did start")

        self.engine.delegate = spy
        self.engine.load(url: URL(fileURLWithPath: self.validFilePath))
        self.engine.play()

        self.waitForExpectations(timeout: self.timeout, handler: nil)

    }

}

private class AudioEngineSpy: AudioEngineDelegate {

    var loadDidStartExpectation: XCTestExpectation?
    var loadDidSucceedExpectation: XCTestExpectation?
    var loadDidFailExpectation: XCTestExpectation?

    var playbackDidStartExpectation: XCTestExpectation?
    var playbackDidStopExpectation: XCTestExpectation?
    var playbackDidFailExpectation: XCTestExpectation?

    var playbackPositionDidChangeExpectation: XCTestExpectation?
    var playbackPosition: Double?

    func loadDidStart() {
        self.loadDidStartExpectation?.fulfill()
    }

    func loadDidSucceed() {
        self.loadDidSucceedExpectation?.fulfill()
    }

    func loadDidFail() {
        self.loadDidFailExpectation?.fulfill()
    }

    func playbackDidStart() {
        self.playbackDidStartExpectation?.fulfill()
    }

    func playbackDidStop() {
        self.playbackDidStopExpectation?.fulfill()
    }

    func playbackDidFail() {
        self.playbackDidFailExpectation?.fulfill()
    }

    func playbackPositionDidChange(position: Double) {
        self.playbackPosition = position
        self.playbackPositionDidChangeExpectation?.fulfill()
    }

}
