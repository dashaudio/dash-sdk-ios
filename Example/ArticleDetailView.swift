//
//  ArticleDetailView.swift
//  Dash
//
//  Created by Dan Halliday on 06/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import UIKit

class ArticleDetailView: UIViewController, ArticleAttachable {

    @IBOutlet weak var textView: UITextView!
    var article: Article?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textView.text = self.article?.body
        self.textView.layoutIfNeeded()
        self.textView.setContentOffset(CGPoint.zero, animated: false)
    }
    
}
