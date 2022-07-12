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

  let imageClassification = ImageClassification()

  @State private var image: UIImage = (.init(named: "image-placeholder") ?? .init())
  @State private var showCamera: Bool = false
  @State private var showPicker: Bool = false

  @State private var predictText: String = ""

  // MARK: Methods

  private func predict(_ image: UIImage) {
    do {
      try imageClassification.predict(with: image, completionHandler: imagePredictionHandler)
    } catch {
      print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
    }
  }

  private func imagePredictionHandler(_ predictions: [ImageClassification.Prediction]?) {
    guard let predictions = predictions else {
      predictText = "No predictions. (Check console log.)"
      return
    }

    let formattedPredictions = formatPredictions(predictions)

    predictText = formattedPredictions.joined(separator: "\n")
  }

  private func formatPredictions(_ predictions: [ImageClassification.Prediction]) -> [String] {
    // Vision sorts the classifications in descending confidence order.
    let topPredictions: [String] = predictions.prefix(1).map { prediction in
      let name = prediction.classification

      return "\(name) - \(prediction.confidencePercentage)%"
    }

    return topPredictions
  }

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
            Text("Prediction: \(predictText)")
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
      ImagePicker(sourceType: .camera, selectedImage: $image, completion: { selected in
        showCamera = false

        if selected {
          self.predict(self.image)
        }
      })
    }
    .sheet(isPresented: $showPicker) {
      ImagePicker(sourceType: .photoLibrary, selectedImage: $image, completion: { selected in
        showPicker = false

        if selected {
          self.predict(self.image)
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
