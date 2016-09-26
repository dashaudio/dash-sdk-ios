//
//  ArticleTests.swift
//  Dash
//
//  Created by Dan Halliday on 26/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import XCTest
@testable import Dash

class ArticleTests: XCTestCase {

    func testInitialiseWithValidDictionary() {

        let dictionary = [
            "id": "http://example.com/article.html",
            "audio": "http://example.com/article.mp3",
            "title": "Article Title"
        ]

        let article = Article(dictionary: dictionary)
        XCTAssert(article != nil, "article should be created from a valid dict")

    }

    func testInitialiseWithInvalidDictionaryUrl() {

        let dictionary = [
            "id": "not a valid url",
            "audio": "http://example.com/article.mp3",
            "title": "Article Title"
        ]

        let article = Article(dictionary: dictionary)
        XCTAssert(article == nil, "article should not be created when dict contains an invalid URL")

    }

    func testInitialiseWithEmptyDictionary() {

        let dictionary: [String:Any] = [:]

        let article = Article(dictionary: dictionary)
        XCTAssert(article == nil, "article should not be created from an empty dict")
        
    }
    
}
