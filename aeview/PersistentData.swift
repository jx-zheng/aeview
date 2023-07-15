//
//  PersistentData.swift
//  aeview
//
//  Created by Kevin Zheng on 2023-07-15.
//

import Foundation

class PersistentData {
    private static let defaults = UserDefaults.standard
    
    static var medicationName: String {
        get { defaults.string(forKey: "medicationName") ?? "" }
        set { defaults.set(newValue, forKey: "medicationName") }
    }
    
    static var chemicalName: String {
        get { defaults.string(forKey: "chemicalName") ?? "" }
        set { defaults.set(newValue, forKey: "chemicalName") }
    }
    
    static var therapyNotes: String {
        get { defaults.string(forKey: "therapyNotes") ?? "" }
        set { defaults.set(newValue, forKey: "therapyNotes") }
    }
    
    static var routeOfAdministration: String {
        get { defaults.string(forKey: "routeOfAdministration") ?? "" }
        set { defaults.set(newValue, forKey: "routeOfAdministration") }
    }
    
}
