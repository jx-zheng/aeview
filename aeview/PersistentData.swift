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
    
    static var dosage: String {
        get { defaults.string(forKey: "dosage") ?? "" }
        set { defaults.set(newValue, forKey: "dosage") }
    }
    
    static var unit: String {
        get { defaults.string(forKey: "unit") ?? "" }
        set { defaults.set(newValue, forKey: "unit") }
    }
    
    static var frequency: String {
        get { defaults.string(forKey: "frequency") ?? "" }
        set { defaults.set(newValue, forKey: "frequency") }
    }
    
    static var lastAdministeredDate: Date? {
        get { (defaults.object(forKey: "lastAdministeredDate") as! Date?) }
        set { defaults.set(newValue, forKey: "lastAdministeredDate") }
    }
    
    static var didChangeDate: Bool {
        get { defaults.bool(forKey: "didChangeDate") }
        set { defaults.set(newValue, forKey: "didChangeDate"); if !newValue { lastAdministeredDate = nil } }
    }

    static var storedNodes: [[Float]] { // Should serialize the nodes as [x, y, z] as rel. offset from bodyAnchor
        get { (defaults.array(forKey: "storedNodes") as? [[Float]]) ?? [[0.0]] }
        set { defaults.set(newValue, forKey: "storedNodes") }
    }
}
