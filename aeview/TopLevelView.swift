//
//  TopLevelView.swift
//  AeView
//
//  Created by Kevin Zheng on 2023-07-16.
//

import SwiftUI

struct TopLevelView: View {
    @State var shouldShowContentView: Bool = false
    
    var body: some View {
        if !shouldShowContentView {
            LoginView(changeToContentView: $shouldShowContentView)
        } else {
            ContentView()
        }
    }
}

struct TopLevelView_Previews: PreviewProvider {
    static var previews: some View {
        TopLevelView()
    }
}
