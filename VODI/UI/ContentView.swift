//
//  ContentView.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 27/04/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                DraftItemListView()
                    .tabItem {
                        Label("Items", systemImage: "archivebox.fill")
                    }
                SandboxView()
                    .tabItem {
                        Label("Sandbox", systemImage: "pencil.slash")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
