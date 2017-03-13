//
//  CreateBeacopnViewController.swift
//  MactsAsBeacon
//
//  Created by Philipp Weiß on 10/03/2017.
//

import Cocoa

class CreateBeaconViewController: NSViewController {
    
    @IBOutlet weak var uuidTextField: NSTextField!
    @IBOutlet weak var majorTextField: NSTextField!
    @IBOutlet weak var minorTextField: NSTextField!
    @IBOutlet weak var powerTextField: NSTextField!
    
    private var viewModel: CreateBeaconViewControllerVMProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uuidTextField.stringValue = viewModel?.uuid ?? ""
        majorTextField.stringValue = viewModel?.major ?? ""
        minorTextField.stringValue = viewModel?.minor ?? ""
        powerTextField.stringValue = viewModel?.power ?? ""
    }
    
    func setViewModel(viewModel: CreateBeaconViewControllerVMProtocol) {
        self.viewModel = viewModel
    }
    
    @IBAction func didCickStartButton(_ sender: NSButton) {
        viewModel?.minor = minorTextField.stringValue
        viewModel?.major = majorTextField.stringValue
        viewModel?.power = powerTextField.stringValue
        viewModel?.uuid = uuidTextField.stringValue
        
        viewModel?.pressedAdvertiseButton()
    }
}
