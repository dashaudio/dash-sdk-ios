//
//  Article.swift
//  Dash
//
//  Created by Dan Halliday on 26/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import Foundation

struct Article {

    let id: URL
    let audio: URL
    let title: String

}

extension Article {

    init?(dictionary: [String:Any]) {

        guard let id = URL(string: dictionary["id"] as? String) else { return nil }
        guard let audio = URL(string: dictionary["audio"] as? String) else { return nil }
        guard let title = dictionary["title"] as? String else { return nil }

        self.id = id
        self.audio = audio
        self.title = title
        
    }
    
}

extension URL {

    init?(string: String?) {
        guard let string = string else { return nil }
        self.init(string: string)
    }

}
