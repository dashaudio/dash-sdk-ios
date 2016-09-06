//
//  Article.swift
//  Dash
//
//  Created by Dan Halliday on 06/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

struct Article {
    let title: String
    let body: String
}

protocol ArticleAttachable {
    var article: Article? { get set }
}

extension Article {

    init?(dictionary: [String:String]) {
        guard let title = dictionary["title"] else { return nil }
        guard let body = dictionary["body"] else { return nil }
        self.title = title
        self.body = body
    }

    static func all() -> [Article] {
        let filePath = Bundle.main.path(forResource: "Articles", ofType: "plist")!
        let fileUrl = URL(fileURLWithPath: filePath)
        let fileData = try! Data(contentsOf: fileUrl)

        let articlesObject = try! PropertyListSerialization.propertyList(from: fileData, format: nil)
        let articlesDictionary = articlesObject as! [[String:String]]

        return articlesDictionary.flatMap { Article(dictionary: $0) }
    }
    
}
