//
//  CreateBeacopnViewController.swift
//  MactsAsBeacon
//
//  Created by Philipp Weiß on 10/03/2017.
//

import Cocoa

class CreateBeaconViewController: NSViewController {

    static let identifier = "CreateBeaconVC"

    @IBOutlet weak var uuidTextField: NSTextField!
    @IBOutlet weak var majorTextField: NSTextField!
    @IBOutlet weak var minorTextField: NSTextField!
    @IBOutlet weak var powerTextField: NSTextField!
    @IBOutlet weak var headerLabel: NSTextField!
    @IBOutlet weak var startStopButton: NSButton!

    private var viewModel: CreateBeaconViewControllerVMProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        uuidTextField.stringValue = viewModel?.uuid ?? ""
        majorTextField.stringValue = viewModel?.major ?? ""
        minorTextField.stringValue = viewModel?.minor ?? ""
        powerTextField.stringValue = viewModel?.power ?? ""
        
        updateActiveState()
    }

    func setViewModel(viewModel: CreateBeaconViewControllerVMProtocol) {
        self.viewModel = viewModel
    }

    func updateActiveState() {
        if viewModel?.isActive == true {
            headerLabel.stringValue = NSLocalizedString("title_broadcasting", comment: "If broadcasting")
            startStopButton.title = NSLocalizedString("button_stop", comment: "Show the stop label")
        } else {
            headerLabel.stringValue = NSLocalizedString("title_not_broadcasting", comment: "If not broadcasting")
            startStopButton.title = NSLocalizedString("button_start", comment: "Show the start label")
        }
    }

    @IBAction func didCickStartButton(_ sender: NSButton) {
        viewModel?.minor = minorTextField.stringValue
        viewModel?.major = majorTextField.stringValue
        viewModel?.power = powerTextField.stringValue
        viewModel?.uuid = uuidTextField.stringValue

        viewModel?.pressedAdvertiseButton()
        
        updateActiveState()
    }
}
