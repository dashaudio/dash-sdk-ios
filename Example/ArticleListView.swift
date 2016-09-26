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

    private var articles: [Article] = []
    private var selectedArticle: Article? = nil
    private let articleStore = ArticleStore()

    override func viewDidLoad() {

        super.viewDidLoad()
        self.reload()

    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        Dash.shared.player.present(over: self.navigationController ?? self)
        Dash.shared.player.minimise()

    }


    func reload() {

        self.articleStore.fetch { result in
            DispatchQueue.main.async { self.update(result: result) }
        }

    }

    func update(result: ArticleStore.Result) {

        switch result {

        case .progress:
            self.navigationItem.prompt = "Loading articles..."

        case .failure:
            self.navigationItem.prompt = "Loading failed!"

        case .success(let articles):
            self.navigationItem.prompt = nil
            self.articles = articles
            self.tableView.reloadData()

        }

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
            Dash.shared.player.load(url: article.id)
        }
        
        Dash.shared.player.maximise()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if var receiver = segue.destination as? ArticleAttachable {
            receiver.article = self.selectedArticle
        }

    }

    @IBAction func reloadButtonWasPressed() {
        self.reload()
    }
    
}
