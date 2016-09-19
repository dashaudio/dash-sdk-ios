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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textView.text = self.article?.body
        self.textView.textContainerInset = self.textContainerInset()
        self.textView.layoutIfNeeded()
        self.textView.contentOffset = CGPoint.zero
    }

    func textContainerInset() -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: Dash.sharedPlayer.theme.size.rawValue + 10, right: 10)
    }
    
}
