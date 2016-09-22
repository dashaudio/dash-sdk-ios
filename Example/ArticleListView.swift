//
//  ArticleListView.swift
//  Dash
//
//  Created by Dan Halliday on 06/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import UIKit
import Dash

class ArticleListView: UITableViewController {

    private let articles = Article.all()
    private var selectedArticle: Article? = nil

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        Dash.shared.player.present(over: self.navigationController ?? self)
        Dash.shared.player.minimise()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.articles.count : 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Examples" : nil
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        cell.textLabel?.text = "📰 " + self.articles[indexPath.row].title

        return cell

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let article = self.articles[indexPath.row]

        self.selectedArticle = article
        self.performSegue(withIdentifier: "showArticleDetail", sender: self)

        if Dash.shared.player.playing == false {
            Dash.shared.player.load(title: article.title, body: article.body, url: article.url)
        }
        
        Dash.shared.player.maximise()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if var receiver = segue.destination as? ArticleAttachable {
            receiver.article = self.selectedArticle
        }

    }
    
}
