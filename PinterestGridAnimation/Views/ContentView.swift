//
//  ContentView.swift
//  PinterestGridAnimation
//
//  Created by Thach Nguyen Trong on 5/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomeView()
                .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
}
