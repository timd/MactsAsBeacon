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

    static let storyboardName = "Main"
    
    private var window: NSWindowController!

    func applicationDidFinishLaunching(_ notification: Notification) {

        let mainVC = NSStoryboard(name: NSStoryboard.Name(rawValue: AppDelegate.storyboardName), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: CreateBeaconViewController.identifier)) as? CreateBeaconViewController

        do {
            mainVC?.setViewModel(viewModel: CreateBeaconViewControllerVM(with: try createBeacon()))
        } catch {
            print(error)
        }

        let win = NSApplication.shared.windows[0]
        win.contentViewController = mainVC
    }

    func createBeacon() throws -> IBeacon {
        let userDef = UserDefaults()

        let uuid = userDef.uuid ?? IBeacon.defaultUUID
        let major = userDef.major ?? IBeacon.defaultMajor
        let minor = userDef.minor ?? IBeacon.defaultMinor
        let power = userDef.power ?? IBeacon.defaultPower

        return IBeacon(uuid: uuid, major: major, minor: minor, power: power)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
