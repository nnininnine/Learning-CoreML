//
//  ContentView.swift
//  Learning-CoreML
//
//  Created by 7Peaks on 12/7/2565 BE.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
  // MARK: Properties

  @State private var image: UIImage = (.init(named: "image-placeholder") ?? .init())
  @State private var showCamera: Bool = false
  @State private var showPicker: Bool = false

  // MARK: Body

  var body: some View {
    NavigationView {
      ZStack(alignment: .bottom) {
        // MARK: Image

        Image(uiImage: image)
          .resizable()
          .scaledToFit()

          // MARK: Overlay Result

          .overlay(
            Text("Prediction: ")
              .foregroundColor(Color(uiColor: .label))
              .padding()
              .background(.ultraThinMaterial)
              .cornerRadius(12)
              .padding(),
            alignment: .topLeading
          )

        // MARK: Photo button

        PhotoButtonGroup(onTapTakePhoto: {
          guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showPicker.toggle()
            return
          }

          showCamera.toggle()
        }, onTapGallery: {
          guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }

          showPicker.toggle()
        })
        .alignmentGuide(VerticalAlignment.bottom) { d in d[.bottom] - 72 }
      } //: ZStack

      .padding(24)
      .navigationTitle("CoreML")
      .navigationBarTitleDisplayMode(.inline)
    } //: NavigationView
    .navigationViewStyle(.stack)
    .sheet(isPresented: $showCamera) {
      ImagePicker(sourceType: .camera, selectedImage: $image)
    }
    .sheet(isPresented: $showPicker) {
      ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
//      let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
//      PhotoPicker(configuration: configuration, selectedImage: $image)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewDevice("iPhone 13")
  }
}
