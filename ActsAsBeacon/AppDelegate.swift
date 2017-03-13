//
//  AppDelegate.swift
//  MactsAsBeacon
//
//  Created by Philipp Weiß on 10/03/2017.
//

import Cocoa
import CoreBluetooth
import IOBluetooth

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    private var window: NSWindowController!

    func applicationDidFinishLaunching(_ notification: Notification) {

        let mainVC = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "CreateBeaconVC") as? CreateBeaconViewController

        do {
            mainVC?.setViewModel(viewModel: CreateBeaconViewControllerVM(with: try createBeacon()))
        } catch {
            print(error)
        }

        let win = NSApplication.shared().windows[0]
        win.contentViewController = mainVC
    }

    func createBeacon() throws -> IBeacon {
        let userDef = UserDefaults()

        
        
        let uuid = userDef.uuid ?? "B0702880-A295-A8AB-F734-031A98A512DE"
        let major = userDef.major ?? "2"
        let minor = userDef.minor ?? "1000"
        let power = userDef.power ?? "58"

        return IBeacon(uuid: uuid, major: major, minor: minor, power: power)
    }
}
