//
//  UserDefaultsExtension.swift
//  MactsAsBeacon
//
//  Created by Philipp Weiß on 10/03/2017.
//

import Foundation


extension UserDefaults {
    
    private static let UUID_KEY = "UUID_KEY"
    private static let POWER_KEY = "POWER_KEY"
    private static let MINOR_KEY = "MINOR_KEY"
    private static let MAJOR_KEY = "MAJOR_KEY"

    var uuid: String? {
        get {
            return value(forKey: UserDefaults.UUID_KEY) as? String
            
        }
        set {
            set(newValue?.description, forKey: UserDefaults.UUID_KEY)
        }
    }
    
    var minor: String? {
        get {
            return value(forKey: UserDefaults.MINOR_KEY) as? String
        }
        set {
            set(newValue, forKey: UserDefaults.MINOR_KEY)
        }
    }
    
    var major: String? {
        get {
            return value(forKey: UserDefaults.MAJOR_KEY) as? String
        }
        set {
            set(newValue, forKey: UserDefaults.MAJOR_KEY)
        }
    }
    
    var power: String? {
        get {
            return value(forKey: UserDefaults.POWER_KEY) as? String
        }
        set {
            set(newValue, forKey: UserDefaults.POWER_KEY)
        }
    }
}
