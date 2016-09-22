//
//  OptionsListView.swift
//  Dash
//
//  Created by Dan Halliday on 08/09/2016.
//  Copyright © 2016 Dash. All rights reserved.
//

import UIKit
import Dash

class OptionsListView: UITableViewController {

    @IBOutlet weak var colorForegroundSlider: UISlider!
    @IBOutlet weak var colorBackgroundSlider: UISlider!

    @IBOutlet weak var verticalAlignmentTopCell: UITableViewCell!
    @IBOutlet weak var verticalAlignmentBottomCell: UITableViewCell!

    @IBOutlet weak var horizontalAlignmentLeftCell: UITableViewCell!
    @IBOutlet weak var horizontalAlignmentRightCell: UITableViewCell!

    @IBOutlet weak var sizeSmallCell: UITableViewCell!
    @IBOutlet weak var sizeMediumCell: UITableViewCell!
    @IBOutlet weak var sizeLargeCell: UITableViewCell!

    @IBOutlet weak var styleRoundingStepper: UIStepper!
    @IBOutlet weak var stylePaddingStepper: UIStepper!

    @IBOutlet weak var styleRoundingLabel: UILabel!
    @IBOutlet weak var stylePaddingLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Dash.shared.player.present(over: self.navigationController ?? self)
        Dash.shared.player.maximise()
        self.update()
    }

    @IBAction func doneButtonWasTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    func update() {

        let theme = Dash.shared.player.theme

        self.verticalAlignmentTopCell.checked = theme.alignment.vertical == .minYEdge
        self.verticalAlignmentBottomCell.checked = theme.alignment.vertical == .maxYEdge

        self.horizontalAlignmentLeftCell.checked = theme.alignment.horizontal == .minXEdge
        self.horizontalAlignmentRightCell.checked = theme.alignment.horizontal == .maxXEdge

        self.sizeSmallCell.checked = theme.size == .small
        self.sizeMediumCell.checked = theme.size == .medium
        self.sizeLargeCell.checked = theme.size == .large

        self.styleRoundingStepper.value = Double(theme.style.rounding)
        self.stylePaddingStepper.value = Double(theme.style.padding)

        self.styleRoundingLabel.text = "\(Int(theme.style.rounding))pt"
        self.stylePaddingLabel.text = "\(Int(theme.style.padding))pt"

        self.tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: theme.size.rawValue, right: 0)

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.cellWasTapped(cell: tableView.cellForRow(at: indexPath)!)
    }

    @IBAction func stepperWasTapped(stepper: UIStepper) {

        switch stepper {

        case self.styleRoundingStepper: Dash.shared.player.theme.style.rounding = CGFloat(stepper.value)
        case self.stylePaddingStepper: Dash.shared.player.theme.style.padding = CGFloat(stepper.value)

        default: break

        }

        self.update()

    }

    @IBAction func sliderWasMoved(slider: UISlider) {

        let color = UIColor(hue: CGFloat(slider.value), saturation: 1, brightness: 1, alpha: 1)

        switch slider {

        case self.colorForegroundSlider: Dash.shared.player.theme.colors.foreground = color
        case self.colorBackgroundSlider: Dash.shared.player.theme.colors.background = color

        default: break

        }

        self.update()

    }

    @IBAction func cellWasTapped(cell: UITableViewCell) {

        switch cell {

        case self.verticalAlignmentTopCell: Dash.shared.player.theme.alignment.vertical = .minYEdge
        case self.verticalAlignmentBottomCell: Dash.shared.player.theme.alignment.vertical = .maxYEdge

        case self.horizontalAlignmentLeftCell: Dash.shared.player.theme.alignment.horizontal = .minXEdge
        case self.horizontalAlignmentRightCell: Dash.shared.player.theme.alignment.horizontal = .maxXEdge

        case self.sizeSmallCell: Dash.shared.player.theme.size = .small
        case self.sizeMediumCell: Dash.shared.player.theme.size = .medium
        case self.sizeLargeCell: Dash.shared.player.theme.size = .large

        default: break

        }

        self.update()

    }

}

extension UITableViewCell {

    var checked: Bool {
        get { return self.accessoryType == .checkmark }
        set { self.accessoryType = newValue ? .checkmark : .none }
    }

}
