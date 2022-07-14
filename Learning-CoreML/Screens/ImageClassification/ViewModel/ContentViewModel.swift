//
//  ContentViewModel.swift
//  Learning-CoreML
//
//  Created by 7Peaks on 12/7/2565 BE.
//

import Foundation
import UIKit

class ContentViewModel: ObservableObject {
  @Published var image: UIImage = (.init(named: "image-placeholder") ?? .init())
  @Published var showCamera: Bool = false
  @Published var showPicker: Bool = false
  @Published var predictedText: String = ""

  let imageClassification = ImageClassification()

  // MARK: Methods

  // Predict
  func predict() {
    do {
      try imageClassification.predict(with: image, completionHandler: imagePredictionHandler)
    } catch {
      print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
    }
  }

  private func imagePredictionHandler(_ predictions: [ImageClassification.Prediction]?) {
    guard let predictions = predictions else {
      predictedText = "No predictions. (Check console log.)"
      return
    }

    let formattedPredictions = formatPredictions(predictions)

    predictedText = formattedPredictions.joined(separator: "\n")
  }

  private func formatPredictions(_ predictions: [ImageClassification.Prediction]) -> [String] {
    // Vision sorts the classifications in descending confidence order.
    let topPredictions: [String] = predictions.prefix(1).map { prediction in
      let name = prediction.classification

      return "\(name) - \(prediction.confidencePercentage)%"
    }

    return topPredictions
  }

  // Select Photo Control
  func takePhoto() {
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
      showPicker.toggle()
      return
    }

    showCamera.toggle()
  }

  func openPicker() {
    guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }

    showPicker.toggle()
  }
}
