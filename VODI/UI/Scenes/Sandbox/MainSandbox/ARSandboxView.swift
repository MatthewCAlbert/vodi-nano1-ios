//
//  ARSandboxView.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 27/04/22.
//

import SwiftUI

struct ARSandboxView: View {
    let exampleShirt = UIImage(named: "ExampleShirt")
//    @StateObject private var model = ARSandboxViewModel()
    
    var body: some View {
        ZStack {
//          FrameView(image: model.frame)
//            .edgesIgnoringSafeArea(.all)
//
//          FrameErrorView(error: model.error)
            ARViewContainer()
                .ignoresSafeArea()
        }
        .navigationBarHidden(true)
    }
}

struct ARSandboxView_Previews: PreviewProvider {
    static var previews: some View {
        ARSandboxView()
    }
}
