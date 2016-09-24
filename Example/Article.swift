//
//  Article.swift
//  Dash
//
//  Created by Dan Halliday on 06/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import Foundation

struct Article {

    let title: String
    let author: String
    let date: String
    let body: String
    let url: String
    let image: String

}

protocol ArticleAttachable {
    var article: Article? { get set }
}

extension Article {

    init?(dictionary: [String:String]) {

        guard let title = dictionary["title"] else { return nil }
        guard let author = dictionary["author"] else { return nil }
        guard let date = dictionary["publishedAt"] else { return nil }
        guard let body = dictionary["description"] else { return nil }
        guard let url = dictionary["url"] else { return nil }
        guard let image = dictionary["urlToImage"] else { return nil }

        self.title = title
        self.author = author
        self.date = date
        self.body = body
        self.url = url
        self.image = image

    }

}
