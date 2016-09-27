//
//  ContentStore.swift
//  Dash
//
//  Created by Dan Halliday on 26/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import Foundation

protocol ArticleStoreDelegate: class {

    func fetchDidStart()
    func fetchDidSucceed(article: Article)
    func fetchDidFail()

}

class ArticleStore {

    weak var delegate: ArticleStoreDelegate?

    private let endpoint = "https://private-378fa2-texttospeech.apiary-mock.com/articles"
    private var task: URLSessionDataTask?

    func fetch(id: URL) {

        // TODO: Delay start callback for a short time and if fetch is fast never send it

        self.task?.cancel()
        self.delegate?.fetchDidStart()

        let url = URL(string: "\(self.endpoint)/\(self.escape(url: id))")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let _ = error {
                self.delegate?.fetchDidFail()
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self.delegate?.fetchDidFail()
                // TODO: handle retry if status == 202
                return
            }

            guard let data = data, data.count > 0 else {
                self.delegate?.fetchDidFail()
                return
            }

            let json: Any

            do { json = try JSONSerialization.jsonObject(with: data) } catch {
                self.delegate?.fetchDidFail()
                return
            }

            guard let dictionary = json as? [String:Any] else {
                self.delegate?.fetchDidFail()
                return
            }

            guard let article = Article(dictionary: dictionary) else {
                self.delegate?.fetchDidFail()
                return
            }

            self.delegate?.fetchDidSucceed(article: article)

        }

        self.task = task
        task.resume()

    }

    private func escape(url: URL) -> String {
        return url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!
    }

}
