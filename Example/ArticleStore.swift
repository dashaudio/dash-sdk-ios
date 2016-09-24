//
//  ArticleStore.swift
//  Dash
//
//  Created by Dan Halliday on 23/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import Foundation

class ArticleStore {

    enum Result {
        case progress, success([Article]), failure
    }

    func fetch(complete: @escaping (_ result: Result) -> Void) {

        complete(.progress)

        let url = URL(string: "https://newsapi.org/v1/articles?source=techcrunch&apiKey=94385e6dbe504c96aaa7d88a5f726652")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let _ = error {
                complete(.failure)
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                complete(.failure)
                return
            }

            guard let data = data, data.count > 0 else {
                complete(.failure)
                return
            }

            let json: Any

            do { json = try JSONSerialization.jsonObject(with: data) } catch {
                complete(.failure)
                return
            }

            guard let array = (json as? NSDictionary)?["articles"] as? [[String:String]] else {
                complete(.failure)
                return
            }

            let articles = array.flatMap { Article(dictionary: $0) }
            print(articles)

            complete(.success(articles))

        }

        task.resume()

    }

}
