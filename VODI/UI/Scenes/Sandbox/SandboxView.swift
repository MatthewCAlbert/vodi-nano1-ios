//
//  SandboxView.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 27/04/22.
//

import SwiftUI

struct SandboxView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: ARSandboxView()) {
                Text("Main Sandbox")
            }
            .buttonStyle(DefaultButtonStyle())
        }
    }
}

struct SandboxView_Previews: PreviewProvider {
    static var previews: some View {
        SandboxView()
    }
}
