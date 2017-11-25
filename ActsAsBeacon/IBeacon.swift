//
//  IBeacon.swift
//  MactsAsBeacon
//
//  Created by Philipp Weiß on 10/03/2017.
//

import Foundation


struct IBeacon {
    static let advertisementKey = "kCBAdvDataAppleBeaconKey"
    
    static let defaultUUID = "B0702880-A295-A8AB-F734-031A98A512DE"
    static let defaultMajor = "2"
    static let defaultMinor = "1000"
    static let defaultPower = "-58"
    
    var uuid: String
    var major: String
    var minor: String
    var power: String
}
