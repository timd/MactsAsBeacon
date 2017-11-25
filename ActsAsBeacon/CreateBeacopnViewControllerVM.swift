//
//  CreateBeacopnViewControllerVM.swift
//  MactsAsBeacon
//
//  Created by Philipp Weiß on 10/03/2017.
//

import Foundation
import CoreBluetooth
import IOBluetooth

protocol CreateBeaconViewControllerVMProtocol: class {

    var major: String { get set }
    var power: String { get set }
    var uuid: String { get set }
    var minor: String { get set }
    var isActive: Bool { get }

    func pressedAdvertiseButton()

}

class CreateBeaconViewControllerVM: NSObject, CreateBeaconViewControllerVMProtocol {
    private var beacon: IBeacon
    private var peripheralManager: CBPeripheralManager?
    private let userDefaults: UserDefaults
    var isActive: Bool = false

    init(with beacon: IBeacon) {
        self.beacon = beacon
        self.userDefaults = UserDefaults()

        super.init()

        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
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
        isActive = !isActive
        
        if isActive {
            let advertisement2 = advertisementData(beacon: beacon)
            peripheralManager?.startAdvertising(advertisement2)
        } else {
            peripheralManager?.stopAdvertising()
        }
    }

    private func advertisementData(beacon: IBeacon) -> [String: Data] {
        var result: [String: Data] = [:]

        var advertisementBytes = [CUnsignedChar](repeating: 0, count: 21)

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

extension CreateBeaconViewControllerVM: CBPeripheralManagerDelegate {

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {

    }
}
