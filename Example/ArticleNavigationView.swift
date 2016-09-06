//
//  ArticleNavigationView.swift
//  Dash
//
//  Created by Dan Halliday on 06/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import UIKit

class ArticleNavigationView: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Dash.shared.show(viewController: self)
    }

}
