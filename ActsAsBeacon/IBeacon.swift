//
//  IBeacon.swift
//  MactsAsBeacon
//
//  Created by Philipp Weiß on 10/03/2017.
//

import Foundation


struct IBeacon {
    static let advertisementKey = "kCBAdvDataAppleBeaconKey"
    
    var uuid: String
    var major: String
    var minor: String
    var power: String
}
