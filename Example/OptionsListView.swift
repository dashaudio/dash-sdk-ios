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

    @IBOutlet weak var verticalPositionSelector: UISegmentedControl!
    @IBOutlet weak var horizontalPositionSelector: UISegmentedControl!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Dash.sharedPlayer.present(over: self.navigationController?.view ?? self.view)
        self.verticalPositionSelector.selectedSegmentIndex
            = Dash.sharedPlayer.theme.alignment.vertical == .minYEdge ? 0 : 1
        self.horizontalPositionSelector.selectedSegmentIndex
            = Dash.sharedPlayer.theme.alignment.horizontal == .minXEdge ? 0 : 1
    }

    @IBAction func verticalPositionSelectorWasPressed(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: Dash.sharedPlayer.theme.alignment.vertical = .minYEdge
        case 1: Dash.sharedPlayer.theme.alignment.vertical = .maxYEdge
        default: break
        }
    }

    @IBAction func horizontalPositionSelectorWasPressed(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: Dash.sharedPlayer.theme.alignment.horizontal = .minXEdge
        case 1: Dash.sharedPlayer.theme.alignment.horizontal = .maxXEdge
        default: break
        }
    }

    @IBAction func doneButtonWasPressed() {
        self.dismiss(animated: true, completion: nil)
    }

}
