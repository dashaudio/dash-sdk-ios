//
//  OptionsListView.swift
//  Dash
//
//  Created by Dan Halliday on 08/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import UIKit
import Dash

class OptionsListView: UIViewController {

    var theme = PlayerTheme()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Dash.sharedPlayer.present(over: self.navigationController?.view ?? self.view)
    }

    @IBAction func verticalPositionSelectorWasPressed(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: self.theme.alignment.vertical = .minYEdge
        case 1: self.theme.alignment.vertical = .maxYEdge
        default: break
        }

        Dash.sharedPlayer.updateTheme(theme: self.theme)
    }

    @IBAction func horizontalPositionSelectorWasPressed(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: self.theme.alignment.horizontal = .minXEdge
        case 1: self.theme.alignment.horizontal = .maxXEdge
        default: break
        }

        Dash.sharedPlayer.updateTheme(theme: self.theme)
    }

    @IBAction func doneButtonWasPressed() {
        self.dismiss(animated: true, completion: nil)
    }

}
