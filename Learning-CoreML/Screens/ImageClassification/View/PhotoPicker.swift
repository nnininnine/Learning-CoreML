//
//  PhotoPicker.swift
//  Learning-CoreML
//
//  Created by 7Peaks on 12/7/2565 BE.
//

import PhotosUI
import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
  @Environment(\.presentationMode) private var presentationMode

  let configuration: PHPickerConfiguration

  @Binding var selectedImage: UIImage

  var itemProviders: [NSItemProvider] = []

  func makeUIViewController(context: Context) -> PHPickerViewController {
    let photoPicker = PHPickerViewController(configuration: configuration)
    photoPicker.delegate = context.coordinator

    return photoPicker
  }

  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  final class Coordinator: PHPickerViewControllerDelegate {
    var parent: PhotoPicker

    init(_ parent: PhotoPicker) {
      self.parent = parent
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

      if results.isEmpty {
        parent.itemProviders = []
        parent.selectedImage = UIImage(named: "image-placeholder") ?? UIImage()

        parent.presentationMode.wrappedValue.dismiss()
      }

      parent.itemProviders = results.map(\.itemProvider)

      loadImage()
    }

    private func loadImage() {
      for itemProvider in parent.itemProviders {
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
          itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            if let image = image as? UIImage {
              self.parent.selectedImage = image
            } else {
              print("Could not load image", error?.localizedDescription ?? "")
            }
            self.parent.presentationMode.wrappedValue.dismiss()
          }
        }
      }
    }
  }
}
