//
//  ArticleDetailView.swift
//  Dash
//
//  Created by Dan Halliday on 06/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import UIKit
import Dash

class ArticleDetailView: UIViewController, ArticleAttachable {

    @IBOutlet weak var textView: UITextView!
    var article: Article?

    override func viewDidLoad() {

        super.viewDidLoad()
        self.textView.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self,
            selector: #selector(self.sizeCategoryDidChange),
            name: NSNotification.Name.UIContentSizeCategoryDidChange,
            object: nil)

        self.updateText()

    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)

    }

    func updateText() {

        guard let article = self.article else {
            self.textView.text = nil
            return
        }

        self.textView.textContainerInset = self.textContainerInset()
        self.textView.layoutIfNeeded()
        self.textView.contentOffset = CGPoint.zero

        let text = NSMutableAttributedString()

        text.append(NSAttributedString(string: article.title, attributes: [
            NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline).withSize(28)]))

        text.append(NSAttributedString(string: "\n\n"))

        text.append(NSAttributedString(string: article.author, attributes: [
            NSFontAttributeName: UIFont.preferredFont(forTextStyle: .caption1)]))

        text.append(NSAttributedString(string: "\n"))

        text.append(NSAttributedString(string: article.date, attributes: [
            NSFontAttributeName: UIFont.preferredFont(forTextStyle: .caption2)]))

        text.append(NSAttributedString(string: "\n\n"))


        text.append(NSAttributedString(string: "🎧 Listen", attributes: [
            NSFontAttributeName: UIFont.preferredFont(forTextStyle: .caption1),
            NSLinkAttributeName: "http://apple.com"
        ]))

        text.append(NSAttributedString(string: "\n\n"))

        text.append(NSAttributedString(string: article.body, attributes: [
            NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body)]))

        self.textView.attributedText = text

    }

    func textContainerInset() -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: Dash.shared.player.theme.size.rawValue + 10, right: 10)
    }

    func sizeCategoryDidChange() {
        self.updateText()
    }

}

extension ArticleDetailView: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        if let article = self.article {
            Dash.shared.player.load(url: article.id)
            Dash.shared.player.play()
        }

        return false

    }

}
