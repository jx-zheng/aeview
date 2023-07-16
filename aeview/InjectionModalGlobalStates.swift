//
//  InjectionModalGlobalStates.swift
//  AeView
//
//  Created by Kevin Zheng on 2023-07-15.
//

import SwiftUI
import RealityKit

class InjectionModalGlobalStates: ObservableObject {
    static let shared = InjectionModalGlobalStates() // singleton for states
    
    @Published var selectedNode: ModelEntity? = nil
    @Published var shouldShowInjectionModal: Bool = false
    
    private init() {}
}
