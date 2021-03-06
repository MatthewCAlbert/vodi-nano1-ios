//
//  ARSandboxViewModel.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 27/04/22.
//

import CoreImage

class ARSandboxViewModel: ObservableObject {
  @Published var error: Error?
  @Published var frame: CGImage?

  private let context = CIContext()

  private let cameraManager = CameraManager.shared
  private let frameManager = FrameManager.shared

  init() {
    setupSubscriptions()
  }

  func setupSubscriptions() {
    // swiftlint:disable:next array_init
    cameraManager.$error
      .receive(on: RunLoop.main)
      .map { $0 }
      .assign(to: &$error)

    frameManager.$current
      .receive(on: RunLoop.main)
      .compactMap { buffer in
        guard let image = CGImage.create(from: buffer) else {
          return nil
        }

        let ciImage = CIImage(cgImage: image)

        return self.context.createCGImage(ciImage, from: ciImage.extent)
      }
      .assign(to: &$frame)
  }
}
