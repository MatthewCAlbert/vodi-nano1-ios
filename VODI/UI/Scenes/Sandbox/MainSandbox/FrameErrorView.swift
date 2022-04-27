//
//  FrameErrorView.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 27/04/22.
//

import SwiftUI

struct FrameErrorView: View {
  var error: Error?

  var body: some View {
    VStack {
      Text(error?.localizedDescription ?? "")
        .bold()
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .padding(8)
        .foregroundColor(.white)
        .background(Color.red.edgesIgnoringSafeArea(.top))
        .opacity(error == nil ? 0.0 : 1.0)
        .animation(.easeInOut, value: 0.25)

      Spacer()
    }
  }
}

struct FrameErrorView_Previews: PreviewProvider {
  static var previews: some View {
      FrameErrorView(error: CameraError.cannotAddInput)
  }
}
