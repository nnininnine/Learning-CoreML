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

  @StateObject private var vm: ContentViewModel = .init()

  // MARK: Methods

  // MARK: Body

  var body: some View {
    NavigationView {
      ZStack(alignment: .bottom) {
        // MARK: Image

        Image(uiImage: vm.image)
          .resizable()
          .scaledToFit()

          // MARK: Overlay Result

          .overlay(
            Text("Prediction: \(vm.predictedText)")
              .foregroundColor(Color(uiColor: .label))
              .padding()
              .background(.ultraThinMaterial)
              .cornerRadius(12)
              .padding(),
            alignment: .topLeading
          )

        // MARK: Photo button

        PhotoButtonGroup(onTapTakePhoto: vm.takePhoto, onTapGallery: vm.openPicker)
          .alignmentGuide(VerticalAlignment.bottom) { d in d[.bottom] - 72 }
      } //: ZStack
      .padding(24)
      .navigationTitle("CoreML")
      .navigationBarTitleDisplayMode(.inline)
    } //: NavigationView
    .navigationViewStyle(.stack)
    .sheet(isPresented: $vm.showCamera) {
      ImagePicker(sourceType: .camera, selectedImage: $vm.image, completion: { selected in
        vm.showCamera = false

        if selected {
          vm.predict()
        }
      })
    }
    .sheet(isPresented: $vm.showPicker) {
      ImagePicker(sourceType: .photoLibrary, selectedImage: $vm.image, completion: { selected in
        vm.showPicker = false

        if selected {
          vm.predict()
        }
      })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewDevice("iPhone 13")
  }
}
