//
//  Article.swift
//  Dash
//
//  Created by Dan Halliday on 06/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import Foundation

struct Article {

    let id: URL

    let title: String
    let author: String
    let date: String
    let body: String

    let image: URL

}

protocol ArticleAttachable {
    var article: Article? { get set }
}

extension Article {

    init?(dictionary: [String:Any]) {

        guard let id = URL(string: dictionary["url"] as? String) else { return nil }
        guard let title = dictionary["title"] as? String else { return nil }
        guard let author = dictionary["author"] as? String else { return nil }
        guard let date = dictionary["publishedAt"] as? String else { return nil }
        guard let body = dictionary["description"] as? String else { return nil }
        guard let image = URL(string: dictionary["urlToImage"] as? String) else { return nil }

        self.id = id
        self.title = title
        self.author = author
        self.date = date
        self.body = body
        self.image = image

    }

}

extension URL {

    init?(string: String?) {
        guard let string = string else { return nil }
        self.init(string: string)
    }

}
