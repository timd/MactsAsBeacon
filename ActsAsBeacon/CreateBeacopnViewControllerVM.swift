//
//  CreateBeacopnViewControllerVM.swift
//  MactsAsBeacon
//
//  Created by Philipp Weiß on 10/03/2017.
//

import Foundation
import CoreBluetooth
import IOBluetooth

protocol CreateBeaconViewControllerVMProtocol {

    var major: String { get set }
    var power: String { get set }
    var uuid: String { get set }
    var minor: String { get set }

    func pressedAdvertiseButton()

}

class CreateBeaconViewControllerVM: NSObject, CreateBeaconViewControllerVMProtocol, CBPeripheralManagerDelegate {
    private var beacon: IBeacon
    private var manager: CBPeripheralManager?
    private let userDefaults: UserDefaults

    init(with beacon: IBeacon) {
        self.beacon = beacon
        self.userDefaults = UserDefaults()
    }

    var major: String {
        get {
            return beacon.major
        }
        set {
            userDefaults.major = newValue
            beacon.major = newValue
        }
    }

    var power: String {
        get {
            return beacon.power
        }
        set {
            userDefaults.power = newValue
            beacon.power = newValue
        }
    }

    var uuid: String {
        get {
            return beacon.uuid
        }
        set {
            userDefaults.uuid = newValue
            beacon.uuid = newValue
        }
    }

    var minor: String {
        get {
            return beacon.minor
        }
        set {
            userDefaults.minor = newValue
            beacon.minor = newValue
        }
    }

    func pressedAdvertiseButton() {
        manager = CBPeripheralManager(delegate: self, queue: nil)
        
        let advertisement2 = advertisementData(beacon: beacon)
        manager?.startAdvertising(advertisement2)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        if peripheral.state == .poweredOn {
        }
    }
    
    private func advertisementData(beacon: IBeacon) -> [String: Data] {
        var result: [String: Data] = [:]
        
        var advertisementBytes = [CUnsignedChar](repeating: 0, count:21)
        
        NSUUID(uuidString: beacon.uuid)!.getBytes(&advertisementBytes)
        
        advertisementBytes[16] = CUnsignedChar(UInt16(beacon.major)! >> 8)
        advertisementBytes[17] = CUnsignedChar(UInt16(beacon.major)! & 255)
        
        advertisementBytes[18] = CUnsignedChar(UInt16(beacon.minor)! >> 8)
        advertisementBytes[19] = CUnsignedChar(UInt16(beacon.minor)! & 255)
        
        advertisementBytes[20] = CUnsignedChar(bitPattern: Int8(beacon.power)!)
        
        let data = Data(bytes: advertisementBytes, count: 21)
        
        result[IBeacon.advertisementKey] = data
        
        return result
    }
}
